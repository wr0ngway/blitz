require File.join(File.dirname(__FILE__), "..", "support", "generator_helper")

class HelperGenerator < Rails::Generators::NamedBase

  def self.source_root
    File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end

  def manifest
    # Check for class naming collisions.
    class_collisions "#{class_name}Helper", "#{class_name}HelperTest"

    # Helper module and test.
    template 'helper.rb',
              File.join('app/helpers',
                        class_path,
                        "#{file_name}_helper.rb")

    template 'helper_test.rb',
              File.join('test/unit/helpers',
                        class_path,
                        "#{file_name}_helper_test.rb")
  end
end
