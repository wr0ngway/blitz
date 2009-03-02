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
               "  end"
    assert body.include?(expected), 
      "expected #{expected} but was #{body.inspect}"
  end
end

Then /^a standard "new" functional test for "(.*)" should be generated$/ do |controller|
  assert_generated_functional_test_for(controller) do |body|
    expected = "  context 'GET to new' do\n" <<
               "    setup { get :new }\n\n" <<
               "    should_respond_with :success\n" <<
               "    should_render_template :new\n" <<
               "    should_assign_to :#{controller}\n" <<
               "  end"
    assert body.include?(expected), 
      "expected #{expected} but was #{body.inspect}"
  end
end

Then /^a standard "create" functional test for "(.*)" should be generated$/ do |controller|
  assert_generated_functional_test_for(controller) do |body|
    expected = "  context 'POST to create with valid parameters' do\n" <<
               "    setup do\n" <<
               "      post :create, :#{controller.chop} => Factory.attributes_for(:#{controller.chop})\n" <<
               "    end\n\n" <<
               "    should_set_the_flash_to /created/i\n" <<
               "    should_redirect_to '#{controller}_path'\n" <<
               "    should_change '#{ controller.capitalize.chop }.count', :by => 1\n" <<
               "  end"
    assert body.include?(expected), 
      "expected #{expected} but was #{body.inspect}"
  end
end

Then /^a "new" controller action for "(.*)" should be generated$/ do |controller|
  assert_generated_controller_for(controller) do |body|
    expected = "  def new\n" <<
               "    @#{controller.chop} = #{controller.capitalize.chop}.new\n" <<
               "  end"
    assert body.include?(expected), 
      "expected #{expected} but was #{body.inspect}"
  end
end

Then /^a "create" controller action for "posts" should be generated$/ do
  assert_generated_controller_for("posts") do |body|
    expected = "  def create\n" <<
               "    @post = Post.new(params[:post])\n" <<
               "    @post.save\n" <<
               "    flash[:success] = 'Post created.'\n" <<
               "    redirect_to posts_path\n" <<
               "  end"
    assert body.include?(expected), 
      "expected #{expected} but was #{body.inspect}"
  end
end
