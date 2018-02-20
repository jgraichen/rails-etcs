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
  end
end
