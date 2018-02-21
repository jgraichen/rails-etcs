# frozen_string_literal: true

RSpec.describe Rails::Etcs::Application do
  let(:app) { Rails.application }
  let(:home) { File.expand_path '~' }

  describe '#config_for' do
    it 'raises error if not found' do
      expect { app.config_for('missing') }.to raise_error RuntimeError
    end

    it 'find matching files' do
      expect(app.config_for('existing')).to eq 'key' => 'value'
    end

    context 'with env: false' do
      it 'returns full configuration file' do
        expect(app.config_for('existing', env: false)).to eq \
          'common' => {'key' => 'value'},
          'test' => {'key' => 'value'}
      end
    end

    context 'with quiet: true' do
      it 'returns nil if not found' do
        expect(app.config_for('missing', quiet: true)).to be nil
      end
    end

    context 'with block' do
      it 'yields config data' do
        expect {|b| app.config_for('existing', &b) }
          .to yield_with_args('key' => 'value')
      end
    end
  end

  describe '#secrets' do
    it 'loads secrets' do
      expect(Rails.application.secrets).to include secret: true
    end
  end
end
