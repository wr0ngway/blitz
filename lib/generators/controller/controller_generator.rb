require File.join(File.dirname(__FILE__), "..", "support", "generator_helper")

class ControllerGenerator < Rails::Generators::NamedBase
  argument :actions, :type => :array, :default => [], :banner => "action action"

  def self.source_root
    File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end

  def manifest
    class_collisions "#{class_name}Controller"

    template 'controller.rb',
             File.join('app/controllers',
                       class_path,
                       "#{file_name}_controller.rb")
  end
end
