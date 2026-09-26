require "test_helper"
require "generators/rori/install/install_generator"

class Rori::Generators::InstallGeneratorTest < Rails::Generators::TestCase
  tests Rori::Generators::InstallGenerator
  destination File.expand_path("../../tmp/generators", __dir__)

  setup do
    prepare_destination
    write "app/controllers/application_controller.rb", <<~RUBY
      class ApplicationController < ActionController::Base
        allow_browser versions: :modern
      end
    RUBY
    write "config/routes.rb", <<~RUBY
      Rails.application.routes.draw do
        resources :notes
      end
    RUBY
    write "app/javascript/controllers/index.js", <<~JS
      import { application } from "controllers/application"
    JS
  end

  test "wires up a fresh app" do
    run_generator

    assert_file "config/initializers/rori.rb", /Rori\.configure do \|rori\|/, /rori\.app_name = /
    assert_file "app/controllers/application_controller.rb", /class ApplicationController < ActionController::Base\n  include Rori::Windowed\n/
    assert_file "config/routes.rb" do |routes|
      assert_match "draw :rori", routes
      assert_match 'root "rori/desktops#show"', routes
    end
    assert_file "app/javascript/controllers/index.js", /import \{ registerRori \} from "rori"\nregisterRori\(application\)/
  end

  test "is idempotent, and keeps an existing root" do
    write "config/routes.rb", <<~RUBY
      Rails.application.routes.draw do
        root "home#show"
      end
    RUBY

    run_generator
    run_generator

    assert_file "app/controllers/application_controller.rb" do |content|
      assert_equal 1, content.scan("include Rori::Windowed").size
    end
    assert_file "config/routes.rb" do |routes|
      assert_equal 1, routes.scan("draw :rori").size
      assert_match 'root "home#show"', routes
      assert_no_match "rori/desktops#show", routes
    end
    assert_file "app/javascript/controllers/index.js" do |content|
      assert_equal 1, content.scan("registerRori(application)").size
    end
  end

  test "skips what the app doesn't have" do
    FileUtils.rm File.join(destination_root, "app/javascript/controllers/index.js")

    output = run_generator

    assert_match "call registerRori(application) yourself", output
  end

  private
    def write(path, content)
      full = File.join(destination_root, path)
      FileUtils.mkdir_p(File.dirname(full))
      File.write(full, content)
    end
end
