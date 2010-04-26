require File.join(File.dirname(__FILE__), "..", "support", "generator_helper")

class FunctionalTestGenerator < Rails::Generators::NamedBase
  argument :actions, :type => :array, :default => [], :banner => "action action"
  
  def self.source_root
    File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end

  def create_functional_test
    class_collisions "#{class_name}ControllerTest"

    template 'functional_test.rb',
             File.join('test/functional',
                       class_path,
                       "#{plural_name}_controller_test.rb")
  end
end

