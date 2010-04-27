require File.join(File.dirname(__FILE__), "..", "support", "generator_helper")

class FeatureGenerator < Rails::Generators::NamedBase
  argument :actions, :type => :array, :default => [], :banner => "action action"

  def self.source_root
    File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end

  def manifest
    path = File.join('features', "#{resources}.feature")
    template 'feature.feature', path

    path = File.join('features', 'step_definitions', "#{resources}_steps.rb")
    template 'step_definition.rb', path

    if actions.any?
      path = File.join('features', 'support', "paths.rb")
      inject_into_file path, insertable_path, :after => "case page_name\n"
    end
  end

  protected
  
  def insertable_path
   if %w(new create).any? { |action| actions.include?(action) }
     "    when /the new #{resource} page/i\n" <<
     "      new_#{resource}_path\n"
   elsif %w(edit update).any? { |action| actions.include?(action) }
     "    when /the edit \"([^\\\"]*)\" #{resource} page/i do |name|\n" <<
     "      post = #{resource_class}.find_by_name(name)\n"
     "      edit_#{resource}_path(#{resource})"
   end
  end
end

