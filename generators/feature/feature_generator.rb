require File.join(File.dirname(__FILE__), "..", "support", "generator_helper")

class FeatureGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory 'features'
      m.directory 'features/step_definitions'

      path = File.join('features', "#{resources}.feature")
      m.template 'feature.feature', path

      path = File.join('features', 'step_definitions', "#{resources}_steps.rb")
      m.template 'step_definition.rb', path
    end
  end
end

