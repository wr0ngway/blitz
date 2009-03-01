Given 'a Rails app' do
  system "rails rails_root"
  @rails_root = File.join(File.dirname(__FILE__), "..", "..", "rails_root")
end

Given /^the coulda plugin is installed$/ do
  plugin_dir = File.join(@rails_root, "vendor", "plugins")
  target     = File.join(File.dirname(__FILE__), "..", "..", "generators")
  FileUtils.mkdir_p "#{plugin_dir}/coulda"
  system "cp -r #{target} #{plugin_dir}/coulda"
end

When /^I generate a model named "(.*)"$/ do |model|
  system "cd #{@rails_root} && " <<
         "script/generate model #{model} && " <<
         "cd .."
end

When /^I generate a model "(.*)" with a (.*) "(.*)"$/ do |model, attr_type, attr_name|
  system "cd #{@rails_root} && " <<
         "script/generate model #{model} #{attr_name}:#{attr_type} && " <<
         "cd .."
end

Then /^"(.*)" has default factory definition for "(.*)"$/ do |file, model|
  assert_directory_exists "test/factories"
  assert_file_exists      "test/factories/#{model}.rb"

  factory  = File.read(File.join(@rails_root, file))
  expected = "Factory.define :#{model.downcase} do |#{model.downcase}|\n" <<
             "end\n"

  assert_equal expected, factory
end

Then /^"(.*)" has factory definition for "(.*)" with (.*) attribute "(.*)"$/ do |file, model, attr_type, attr_name|
  factory  = File.read(File.join(@rails_root, file))
  expected = "Factory.define :#{model.downcase} do |#{model.downcase}|\n" <<
             "  #{model.downcase}.#{attr_name} { '#{attr_type}' }\n" <<
             "end\n"

  assert_equal expected, factory
end

Then /^a file named '(.*)' is not created$/ do |file|
  file = File.join(@rails_root, file)
 
  assert ! File.exists?(file), "#{file} expected to not exist, but did"
end

After do
  FileUtils.rm_rf @rails_root if @rails_root
end

