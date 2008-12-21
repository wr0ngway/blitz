require 'rake'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

desc "Run the test suite"
task :default => 'test'

begin
  require 'rubygems'
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name        = "coulda"
    s.summary     = "Rails generators that create Shoulda & Factory Girl tests."
    s.email       = "hardbap@gmail.com"
    s.homepage    = "http://github.com/hardbap/coulda"
    s.description = "Rails generators that create Shoulda & Factory Girl tests."
    s.authors     = ["Mike Breen"]
    s.files       = FileList["[A-Z]*", "{generators,lib,test}/**/*"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
