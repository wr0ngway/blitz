require File.join(File.dirname(__FILE__), "insert_commands")

module Coulda
  module GeneratorHelper
    def resource
      file_name.singularize
    end

    def resources
      file_name.pluralize
    end

    def resource_class
      class_name.singularize
    end
  end
end

class Rails::Generator::NamedBase
  include Coulda::GeneratorHelper
end

