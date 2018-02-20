# frozen_string_literal: true

require 'rake/release/task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

Rake::Release::Task.new do |spec|
  spec.sign_tag = true
end
