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

Then /^a factory should be generated for "(.*)"$/ do |model|
  model.downcase!
  assert_generated_factory_for(model) do |body|
    expected = "Factory.define :#{model.downcase} do |#{model.downcase}|\n" <<
               "end\n"
    assert_equal expected, body
  end
end

Then /^a factory for "(.*)" should have an? "(.*)" (.*)$/ do |model, attr_name, attr_type|
  model.downcase!
  assert_generated_factory_for(model) do |body|
    expected = "Factory.define :#{model} do |#{model}|\n" <<
               "  #{model}.#{attr_name} { '#{attr_type}' }\n" <<
               "end\n"
    assert_equal expected, body
  end
end

Then /^a unit test should be generated for "(.*)"$/ do |model|
  model.downcase!
  assert_generated_unit_test_for(model)
end

After do
  FileUtils.rm_rf @rails_root if @rails_root
end

