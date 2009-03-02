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

When /^I generate a model "(.*)" that belongs to a "(.*)"$/ do |model, association|
  association.downcase!
  system "cd #{@rails_root} && " <<
         "script/generate model #{model} #{association}:belongs_to && " <<
         "cd .."
end

Then /^an empty "(.*)" view for "(.*)" should be generated$/ do |action, controller|
  assert_generated_views_for(controller, action)
end

Then /^an empty "(.*)" controller action for "(.*)" should be generated$/ do |action, controller|
  assert_generated_controller_for(controller) do |body|
    assert_has_empty_method(body, action)
  end
end

Then /^a helper should be generated for "(.*)"$/ do |name|
  assert_generated_helper_for(name)
end

Then /^a helper test should be generated for "(.*)"$/ do |name|
  assert_generated_helper_test_for(name)
end

After do
  FileUtils.rm_rf @rails_root if @rails_root
end

