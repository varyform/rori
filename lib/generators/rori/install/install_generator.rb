require "rails/generators"

module Rori
  module Generators
    # bin/rails g rori:install — wires a host app up for the desk. Idempotent:
    # steps that find their line already in place skip themselves.
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Adds the rori initializer, Rori::Windowed, the desk's routes and its Stimulus controllers."

      def create_initializer
        template "rori.rb", "config/initializers/rori.rb"
      end

      def include_windowed
        path = "app/controllers/application_controller.rb"
        return say_status(:skip, "#{path} not found", :yellow) unless exist?(path)
        return if read(path).include?("Rori::Windowed")

        inject_into_class path, "ApplicationController", "  include Rori::Windowed\n\n"
      end

      def draw_routes
        path = "config/routes.rb"
        return say_status(:skip, "#{path} not found", :yellow) unless exist?(path)

        routes = read(path)
        route "draw :rori" unless routes.include?("draw :rori")
        if routes.match?(/^\s*root\b/)
          say_status :skip, "root route already set; the blank desk is rori/desktops#show", :yellow
        else
          route 'root "rori/desktops#show"'
        end
      end

      def register_stimulus_controllers
        path = "app/javascript/controllers/index.js"
        return say_status(:skip, "#{path} not found; call registerRori(application) yourself", :yellow) unless exist?(path)
        return if read(path).include?("registerRori")

        append_to_file path, <<~JS

          import { registerRori } from "rori"
          registerRori(application)
        JS
      end

      def next_steps
        say <<~TEXT

          rori is wired up. Next:
            • Place the desk's CSS among your layers, e.g. in your first stylesheet:
                @layer reset, base, rori, layout, components, utilities;
            • Label pages for ⌘K under rori.commands.routes.<controller>.<action>
              in your locale, and list models in config/initializers/rori.rb.
            • Start the server and press ⌘K (or space on the empty desk).
        TEXT
      end

      private
        def exist?(path) = File.exist?(File.join(destination_root, path))

        def read(path) = File.read(File.join(destination_root, path))
    end
  end
end
