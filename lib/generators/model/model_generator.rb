require File.join(File.dirname(__FILE__), "..", "support", "generator_helper")

class ModelGenerator < Rails::Generators::NamedBase
  argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
  
  class_option :skip_timestamps, :type => :boolean, :default => false, :desc => "Skip timestamps"
  class_option :skip_migration, :type => :boolean, :default => false, :desc => "Skip migration"
  class_option :skip_factories, :type => :boolean, :default => false, :desc => "Skip factories"

  def self.source_root
    File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
  end

  def manifest
    # Check for class naming collisions.
    class_collisions class_name, "#{class_name}Test"

    # Model class, unit test, and factories.
    template 'model.rb',      File.join('app/models', class_path,
                                          "#{file_name}.rb")
    template 'unit_test.rb',  File.join('test/unit', class_path,
                                          "#{file_name}_test.rb")

    template 'factory.rb',  File.join('test/factories', "#{file_name}.rb")

    unless options[:skip_migration]
      migration_template 'migration.rb', 'db/migrate', :assigns => {
        :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
      }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
    end
  end

  protected

    def factory_line(attribute, file_name)
      if attribute.reference?
        "#{file_name}.association(:#{attribute.name})"
      else
        "#{file_name}.#{attribute.name} #{attribute.default_for_factory}"
      end
    end

    def banner
      "Usage: #{$0} #{spec.name} ModelName [field:type, field:type]"
    end

    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on("--skip-timestamps",
             "Don't add timestamps to the migration file for this model") { |v| 
        options[:skip_timestamps] = v 
      }
      opt.on("--skip-migration", 
             "Don't generate a migration file for this model") { |v| 
        options[:skip_migration] = v 
      }
    end
end

module Rails
  module Generators
    class GeneratedAttribute
      def default_for_factory
        @default ||= case type
          when :integer                     then "{ 1 }"
          when :float                       then "{ 1.5 }"
          when :decimal                     then "{ 9.99 }"
          when :datetime, :timestamp, :time then "{ Time.now.to_s(:db) }"
          when :date                        then "{ Date.today.to_s(:db) }"
          when :string                      then "{ 'string' }"
          when :text                        then "{ 'text' }"
          when :boolean                     then "{ false }"
          else
            ""
        end
      end
    end
  end
end
