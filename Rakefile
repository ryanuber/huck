require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new
task :default => [:spec]

task :website_push do
  exec "git push -f web $(git subtree split -q --prefix website master):refs/heads/master"
end
