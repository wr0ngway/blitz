require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'
require 'date'

test_files_pattern = 'test/rails_root/test/{unit,functional,other}/**/*_test.rb'
namespace :test do
  Rake::TestTask.new(:all => 'generator:tests') do |t|
    t.libs << 'lib'
    t.pattern = test_files_pattern
    t.verbose = false
  end
end

desc "Run the test suite"
task :default => 'test:all'

begin
  require 'rubygems'
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "coulda"
    s.summary = "Rails generators that create Shoulda & Factory Girl tests."
    s.email = "hardbap@gmail.com"
    s.homepage = "http://github.com/hardbap/coulda"
    s.description = "Rails generators that create Shoulda & Factory Girl tests."
    s.authors = ["Mike Breen"]
    s.files = FileList["[A-Z]*", "{generators,lib,test}/**/*"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

namespace :generator do
  desc "Run the generator on the tests"
  task :tests do
    system "mkdir -p test/rails_root/vendor/plugins/coulda"
    system "cp -R generators test/rails_root/vendor/plugins/coulda"
    system "cd test/rails_root"
    system "./script/generate coulda_scaffold post title:string body:text user:belongs_to"
  end
end
