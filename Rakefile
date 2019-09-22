require 'rake'
require 'rspec/core/rake_task'
require 'yaml'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do

  # target list
  specs = YAML.load_file('./spec/spec.yml')

  # target's host
  hosts = []
  specs.each do |spec|
    hosts << spec["name"]
  end

  task :all     => hosts
  task :default => :all

  # define tasks
  specs.each do |spec|
    desc "Run serverspec tests to #{spec['name']}"
    RSpec::Core::RakeTask.new(spec["name"].to_sym) do |t|
      ENV['TARGET_HOST'] = spec["name"]
      t.pattern = "spec/{" + spec["roles"].join(',') + "}/*_spec.rb"
    end
  end
end
