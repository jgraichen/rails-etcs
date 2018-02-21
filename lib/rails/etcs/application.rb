# frozen_string_literal: true

module Rails::Etcs
  module Application
    extend ActiveSupport::Concern

    require 'rails/etcs/application/configuration'

    included do
      attr_writer :ident

      def ident
        @ident ||= begin
          self.class.name.underscore
              .gsub(/[^A-z]+/, '-')
              .gsub(/-application$/, '')
        end
      end
    end

    def config
      @config ||= begin
        root = self.class.find_root self.class.called_from

        Application::Configuration.new root, self.class.ident
      end
    end

    # rubocop:disable AbcSize
    # rubocop:disable MethodLength
    def config_for(name, env: Rails.env)
      files = paths['config']
              .expanded
              .map {|d| Pathname.new(d).join("#{name}.yml") }

      yaml = files.find(&:exist?)

      unless yaml
        raise "Could not load configuration. No such file - #{files.join(', ')}"
      end

      require 'erb'

      data = YAML.safe_load(ERB.new(yaml.read).result, [], [], true) || {}
      data.fetch(env, {})
    rescue Psych::SyntaxError => e
      raise <<~ERR
        YAML syntax error occurred while parsing #{yaml}.
        Please note that YAML must be consistently indented using spaces.
        Tabs are not allowed.
        Error: #{e.message}
      ERR
    end
    # rubocop:enable all
  end
end
