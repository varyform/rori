require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)
require "rori"

# A minimal host app for the engine's tests: its ApplicationController
# includes Rori::Windowed, its routes draw :rori, and the desk is its root.
module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    config.root = File.expand_path("..", __dir__)
  end
end
