# frozen_string_literal: true

require 'bundler/setup'
require 'rails/etcs'

ENV['XDG_CONFIG_DIRS'] = '/etc/xdg:/etc:spec/static/config'

STDOUT.puts "Rails.env: #{Rails.env}"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'spec/examples.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
