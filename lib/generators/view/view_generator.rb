require File.join(File.dirname(__FILE__), "..", "support", "generator_helper")

class ViewGenerator < Rails::Generators::NamedBase
  argument :actions, :type => :array, :default => [], :banner => "action action"
  class_option :empty, :type => :boolean, :default => false, :desc => "Generate empty"

  def self.source_root
    File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end

  def manifest
    if actions.include?("new")
      path = File.join('app/views', class_path, file_name, "new.html.erb")
      if options[:empty]
        file 'empty.html.erb', path
      else
        template 'new.html.erb', path
      end
    elsif actions.include?("index")
      path = File.join('app/views', class_path, file_name,
                       "index.html.erb")
      template "index.html.erb", path
    end
  end

  protected

  def add_options!(opt)
    opt.on('-e', '--empty') { options[:empty] = true }
  end
end
