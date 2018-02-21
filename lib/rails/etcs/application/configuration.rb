# frozen_string_literal: true

require 'xdg'

module Rails::Etcs::Application
  class Configuration < ::Rails::Application::Configuration
    attr_reader :ident

    def initialize(root, ident)
      super root

      @ident = ident
    end

    # rubocop:disable AbcSize
    # rubocop:disable MethodLength
    def paths
      @paths ||= begin
        paths = super

        paths.add 'lib',    eager_load: true
        paths.add 'tmp',    with: xdg_cache.flatten
        paths.add 'config', with: xdg_config.flatten

        paths.add 'config/environment',
          with: %w[app/environment.rb config/environment.rb]

        paths.add 'config/initializers',
          with: %w[app/initializers],
          glob: '**/*.rb'

        paths.add 'config/locales',
          with: %w[app/locales config/locales],
          glob: '*.{rb,yml}'

        paths.add 'config/routes.rb',
          with: %w[app/routes.rb config/routes.rb]

        paths.add 'config/environments',
          with: %w[app/environments],
          glob: "#{Rails.env}.rb"

        paths.add 'config/database',
          with: paths['config'].each.map {|d| File.join(d, 'database.yml') }

        paths.add 'config/secrets',
          with: paths['config'],
          glob: 'secrets.yml{,.enc}'

        if Gem::Requirement.new('< 5.1') =~ Gem::Version.new(Rails.version)
          # Rails < 5.1 does not check for existing secrets file but just
          # uses the first path even if it does not exist.
          #
          # This workaround fixes that by pre-expanding the path with only
          # existing files.
          paths.add 'config/secrets', with: paths['config/secrets'].existent
        end

        paths['config'].to_ary.reverse.each do |dir|
          paths['config/initializers'] << File.join(dir, 'initializers')
          paths['config/environments'] << File.join(dir, 'environments')
        end

        paths
      end
    end
    # rubocop:enable all

    private

    def xdg_config
      [XDG['CONFIG'].with_subdirectory(ident), 'config'].flatten
    end

    def xdg_cache
      [XDG['CACHE'].with_subdirectory(ident).to_ary.reverse, 'tmp'].flatten
    end
  end
end
