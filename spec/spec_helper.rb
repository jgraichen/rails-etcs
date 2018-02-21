# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
ENV['XDG_CONFIG_DIRS'] = '/etc/xdg:/etc:spec/static/config'

require 'bundler/setup'
require 'rails/etcs'

require 'pry'
require 'pry-byebug'

class Application < ::Rails::Application
  include ::Rails::Etcs::Application

  self.ident = 'rails-etcs'
end

module Constraint
  def constraint(**kwargs)
    yield if kwargs.each_pair.all? {|k, v| send(k, v) }
  end

  def rails(values)
    Gem::Requirement.new(*Array(values)).satisfied_by? \
      Gem::Version.new(Rails.version)
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = 'spec/examples.txt'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.extend Constraint
end
