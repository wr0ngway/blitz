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

When /^I generate a "(.*)" controller with "(.*)" action$/ do |controller, action|
  system "cd #{@rails_root} && " <<
         "script/generate controller #{controller} #{action} && " <<
         "cd .."
end

When /^I generate a helper named "(.*)"$/ do |name|
  system "cd #{@rails_root} && " <<
         "script/generate helper #{name} && " <<
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

Then /^a factory for "(.*)" should have an association to "(.*)"$/ do |model, associated_model|
  model.downcase!
  associated_model.downcase!
  assert_generated_factory_for(model) do |body|
    expected = "Factory.define :#{model} do |#{model}|\n" <<
               "  #{model}.association(:#{associated_model})\n" <<
               "end\n"
    assert_equal expected, body
  end
end

Then /^a unit test should be generated for "(.*)"$/ do |model|
  model.downcase!
  assert_generated_unit_test_for(model) do |body|
    match = "assert_valid Factory.build(:#{model})"
    assert body.include?(match), body.inspect
  end
end

Then /^the "(.*)" unit test should have "(.*)" macro$/ do |model, macro|
  model.downcase!
  assert_generated_unit_test_for(model) do |body|
    assert body.include?(macro), body.inspect
  end
end

Then /^the "(.*)" table should have db index on "(.*)"$/ do |table, foreign_key|
  assert_generated_migration(table) do |body|
    index = "add_index :#{table}, :#{foreign_key}"
    assert body.include?(index), body.inspect
  end
end

Then /^a standard "index" functional test for "(.*)" should be generated$/ do |controller|
  assert_generated_functional_test_for(controller) do |body|
    expected = "  context 'GET to index' do\n" <<
               "    setup { get :index }\n\n" <<
               "    should_respond_with :success\n" <<
               "    should_render_template :index\n" <<
               "    should_assign_to :#{controller}\n" <<
               "  end"
    assert body.include?(expected), body.inspect
  end
end

Then /^an empty "(.*)" view for "(.*)" should be generated$/ do |index, controller|
  assert_generated_views_for(controller, index)
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
