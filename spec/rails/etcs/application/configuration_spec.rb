# frozen_string_literal: true

RSpec.describe Rails::Etcs::Application::Configuration do
  let(:config) { Rails.application.config }
  let(:home) { File.expand_path '~' }
  let(:ident) { 'rails-etcs' }
  let(:static) { File.expand_path "spec/static/config/#{ident}" }

  describe 'paths' do
    describe 'lib' do
      subject { config.paths['lib'] }

      it do
        expect(subject.to_ary).to eq %w[lib]
      end

      it 'should have no glob' do
        expect(subject.glob).to be nil
      end

      it 'should be eager loaded' do
        expect(subject.eager_load?).to be true
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'config' do
      subject { config.paths['config'] }

      it do
        expect(subject.to_ary)
          .to eq %W[
            #{home}/.config/#{ident}
            /etc/xdg/#{ident}
            /etc/#{ident}
            #{static}
            config
          ]
      end

      it 'should have no glob' do
        expect(subject.glob).to be nil
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'config/environment' do
      subject { config.paths['config/environment'] }

      it do
        expect(subject.to_ary)
          .to eq %w[app/environment.rb config/environment.rb]
      end

      it 'should have no glob' do
        expect(subject.glob).to be nil
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'config/environments' do
      subject { config.paths['config/environments'] }

      it do
        expect(subject.to_ary)
          .to eq %W[
            app/environments
            config/environments
            #{static}/environments
            /etc/#{ident}/environments
            /etc/xdg/#{ident}/environments
            #{home}/.config/#{ident}/environments
          ]
      end

      it 'should have "#{Rails.env}.rb" glob' do
        expect(subject.glob).to eq "#{Rails.env}.rb"
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'config/database' do
      subject { config.paths['config/database'] }

      it do
        expect(subject.to_ary)
          .to eq %W[
            #{home}/.config/#{ident}/database.yml
            /etc/xdg/#{ident}/database.yml
            /etc/#{ident}/database.yml
            #{static}/database.yml
            config/database.yml
          ]
      end

      it 'should not have a glob' do
        expect(subject.glob).to eq nil
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'config/initializers' do
      subject { config.paths['config/initializers'] }

      it do
        expect(subject.to_ary)
          .to eq %W[
            app/initializers
            config/initializers
            #{static}/initializers
            /etc/#{ident}/initializers
            /etc/xdg/#{ident}/initializers
            #{home}/.config/#{ident}/initializers
          ]
      end

      it 'should have "**/*.rb" glob' do
        expect(subject.glob).to eq '**/*.rb'
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'config/locales' do
      subject { config.paths['config/locales'] }

      it do
        expect(subject.to_ary)
          .to eq %w[app/locales config/locales]
      end

      it 'should have "*.{rb,yml}" glob' do
        expect(subject.glob).to eq '*.{rb,yml}'
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'config/routes.rb' do
      subject { config.paths['config/routes.rb'] }

      it do
        expect(subject.to_ary)
          .to eq %w[app/routes.rb config/routes.rb]
      end

      it 'should have no glob' do
        expect(subject.glob).to be nil
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'config/secrets' do
      subject { config.paths['config/secrets'] }

      it do
        expect(subject.to_ary)
          .to eq %W[
            #{home}/.config/#{ident}
            /etc/xdg/#{ident}
            /etc/#{ident}
            #{static}
            config
          ]
      end

      it 'should have "secrets.yml{,.enc}" glob' do
        expect(subject.glob).to eq 'secrets.yml{,.enc}'
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end

    describe 'tmp' do
      subject { config.paths['tmp'] }

      it do
        expect(subject.to_ary)
          .to eq %W[
            /tmp/#{ident}
            #{home}/.cache/#{ident}
            tmp
          ]
      end

      it 'should have no glob' do
        expect(subject.glob).to be nil
      end

      it 'should not be eager loaded' do
        expect(subject.eager_load?).to be false
      end

      it 'should not autoload' do
        expect(subject.autoload?).to be false
      end

      it 'should not autoload once' do
        expect(subject.autoload_once?).to be false
      end

      it 'should not be on load path' do
        expect(subject.load_path?).to be false
      end
    end
  end
end
