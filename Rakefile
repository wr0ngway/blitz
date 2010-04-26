require 'rake'
require 'rake/testtask'

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |features|
  features.cucumber_opts = "features --format progress"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "blitz"
    gem.summary = %Q{A Rails plugin for feature, view, controller, model, & helper generators.}
    gem.description = %Q{A Rails plugin for feature, view, controller, model, & helper generators. It is meant to be used as part of an "Outside-In" Test-Driven Development cycle.}
    gem.email = "wr0ngway@yahoo.com"
    gem.homepage = "http://github.com/wr0ngway/blitz"
    gem.authors = ["Matt Conway"]
    gem.add_dependency 'railties', '>= 3.0.0.beta3'
    gem.files =  FileList["[A-Z][A-Z]*", "{generators,lib}/**/*"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "blitz #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => [:features]

