require 'bundler/setup'
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
rescue LoadError
  task :rubocop do
  end
end

RSpec::Core::RakeTask.new(:spec)

task ci: [:rubocop, :spec]
task default: :spec
