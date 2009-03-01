require 'test/unit'

module Test::Unit::Assertions
  def assert_generated_controller_for(name, parent = "ApplicationController")
    assert_generated_class "app/controllers/#{name.to_s.underscore}_controller", parent do |body|
      yield body if block_given?
    end
  end

  def assert_generated_model_for(name, parent = "ActiveRecord::Base")
    assert_generated_class "app/models/#{name.to_s.underscore}", parent do |body|
      yield body if block_given?
    end
  end

  def assert_generated_helper_for(name)
    assert_generated_module "app/helpers/#{name.to_s.underscore}_helper" do |body|
      yield body if block_given?
    end
  end

  def assert_generated_functional_test_for(name, parent = "ActionController::TestCase")
    assert_generated_class "test/functional/#{name.to_s.underscore}_controller_test", parent do |body|
      yield body if block_given?
    end
  end

  def assert_generated_unit_test_for(name, parent = "ActiveSupport::TestCase")
    assert_generated_class "test/unit/#{name.to_s.underscore}_test", parent do |body|
      yield body if block_given?
    end
  end

  def assert_generated_file(path)
    assert_file_exists(path)
    File.open(File.join(@rails_root, path)) do |file|
      yield file.read if block_given?
    end
  end

  def assert_file_exists(path)
    file = File.join(@rails_root, path)

    assert File.exists?(file), "#{file} expected to exist, but did not"
    assert File.file?(file),   "#{file} expected to be a file, but is not"
  end

  def assert_directory_exists(path)
    directory = File.join(@rails_root, path)

    assert File.exists?(directory),    "#{directory} did not exist"
    assert File.directory?(directory), "#{directory} is not a directory"
  end

  def assert_generated_class(path, parent = nil)
    # FIXME: Sucky way to detect namespaced classes
    if path.split('/').size > 3
      path =~ /\/?(\d+_)?(\w+)\/(\w+)$/
      class_name = "#{$2.camelize}::#{$3.camelize}"
    else
      path =~ /\/?(\d+_)?(\w+)$/
      class_name = $2.camelize
    end

    assert_generated_file("#{path}.rb") do |body|
      assert_match /class #{class_name}#{parent.nil? ? '':" < #{parent}"}/, body, "the file '#{path}.rb' should be a class"
      yield body if block_given?
    end
  end

  def assert_generated_module(path)
    # FIXME: Sucky way to detect namespaced modules
    if path.split('/').size > 3
      path =~ /\/?(\w+)\/(\w+)$/
      module_name = "#{$1.camelize}::#{$2.camelize}"
    else
      path =~ /\/?(\w+)$/
      module_name = $1.camelize
    end

    assert_generated_file("#{path}.rb") do |body|
      assert_match /module #{module_name}/, body, "the file '#{path}.rb' should be a module"
      yield body if block_given?
    end
  end

  def assert_generated_views_for(name, *actions)
    actions.each do |action|
      assert_generated_file("app/views/#{name.to_s.underscore}/#{action}") do |body|
        yield body if block_given?
      end
    end
  end

  def assert_generated_migration(name, parent = "ActiveRecord::Migration")
    file = Dir.glob("#{@rails_root}/db/migrate/*_#{name.to_s.underscore}.rb").first
    file = file.match(/db\/migrate\/[0-9]+_\w+/).to_s
    assert_generated_class file, parent do |body|
      assert_match /timestamps/, body, "should have timestamps defined"
      yield body if block_given?
    end
  end

  def assert_added_route_for(name)
    assert_generated_file("config/routes.rb") do |body|
      assert_match /map.resources :#{name.to_s.underscore}/, body,
        "should add route for :#{name.to_s.underscore}"
    end
  end

  def assert_has_method(body, *methods)
    methods.each do |name|
      assert body =~ /^  def #{name}(\(.+\))?\n((\n|   .*\n)*)  end/, "should have method #{name}"
      yield(name, $2) if block_given?
    end
  end

  def assert_generated_column(body, name, type)
    assert_match /t\.#{type.to_s} :#{name.to_s}/, body, "should have column #{name.to_s} defined"
  end  
end

World do |world|
  world.extend(Test::Unit::Assertions)
  world
end

