# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{coulda}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Breen", "Dan Croak"]
  s.date = %q{2009-01-09}
  s.description = %q{Rails generators that create Shoulda & Factory Girl tests.}
  s.email = %q{hardbap@gmail.com}
  s.files = ["LICENSE", "Rakefile", "README.markdown", "TODO", "VERSION.yml", "generators/coulda_model", "generators/coulda_model/coulda_model_generator.rb", "generators/coulda_model/templates", "generators/coulda_model/templates/factory.rb", "generators/coulda_model/templates/migration.rb", "generators/coulda_model/templates/model.rb", "generators/coulda_model/templates/unit_test.rb", "generators/coulda_model/USAGE", "generators/coulda_scaffold", "generators/coulda_scaffold/coulda_scaffold_generator.rb", "generators/coulda_scaffold/templates", "generators/coulda_scaffold/templates/controller.rb", "generators/coulda_scaffold/templates/functional_test", "generators/coulda_scaffold/templates/functional_test/shoulda_controller.rb", "generators/coulda_scaffold/templates/helper.rb", "generators/coulda_scaffold/templates/helper_test.rb", "generators/coulda_scaffold/templates/view", "generators/coulda_scaffold/templates/view/_form.html.erb", "generators/coulda_scaffold/templates/view/edit.html.erb", "generators/coulda_scaffold/templates/view/index.html.erb", "generators/coulda_scaffold/templates/view/new.html.erb", "generators/coulda_scaffold/templates/view/show.html.erb", "generators/coulda_scaffold/USAGE", "lib/coulda.rb", "test/fixtures", "test/fixtures/about_yml_plugins", "test/fixtures/about_yml_plugins/bad_about_yml", "test/fixtures/about_yml_plugins/bad_about_yml/about.yml", "test/fixtures/about_yml_plugins/bad_about_yml/init.rb", "test/fixtures/about_yml_plugins/plugin_without_about_yml", "test/fixtures/about_yml_plugins/plugin_without_about_yml/init.rb", "test/fixtures/eager", "test/fixtures/eager/zoo", "test/fixtures/eager/zoo/reptile_house.rb", "test/fixtures/eager/zoo.rb", "test/fixtures/environment_with_constant.rb", "test/fixtures/lib", "test/fixtures/lib/generators", "test/fixtures/lib/generators/missing_class", "test/fixtures/lib/generators/missing_class/missing_class_generator.rb", "test/fixtures/lib/generators/missing_class/templates", "test/fixtures/lib/generators/missing_generator", "test/fixtures/lib/generators/missing_generator/templates", "test/fixtures/lib/generators/missing_templates", "test/fixtures/lib/generators/working", "test/fixtures/lib/generators/working/working_generator.rb", "test/fixtures/plugins", "test/fixtures/plugins/alternate", "test/fixtures/plugins/alternate/a", "test/fixtures/plugins/alternate/a/generators", "test/fixtures/plugins/alternate/a/generators/a_generator", "test/fixtures/plugins/alternate/a/generators/a_generator/a_generator.rb", "test/fixtures/plugins/alternate/a/lib", "test/fixtures/plugins/default", "test/fixtures/plugins/default/acts", "test/fixtures/plugins/default/acts/acts_as_chunky_bacon", "test/fixtures/plugins/default/acts/acts_as_chunky_bacon/lib", "test/fixtures/plugins/default/empty", "test/fixtures/plugins/default/gemlike", "test/fixtures/plugins/default/gemlike/init.rb", "test/fixtures/plugins/default/gemlike/lib", "test/fixtures/plugins/default/gemlike/lib/gemlike.rb", "test/fixtures/plugins/default/gemlike/rails", "test/fixtures/plugins/default/gemlike/rails/init.rb", "test/fixtures/plugins/default/plugin_with_no_lib_dir", "test/fixtures/plugins/default/plugin_with_no_lib_dir/init.rb", "test/fixtures/plugins/default/stubby", "test/fixtures/plugins/default/stubby/about.yml", "test/fixtures/plugins/default/stubby/generators", "test/fixtures/plugins/default/stubby/generators/stubby_generator", "test/fixtures/plugins/default/stubby/generators/stubby_generator/stubby_generator.rb", "test/fixtures/plugins/default/stubby/init.rb", "test/fixtures/plugins/default/stubby/lib", "test/fixtures/plugins/default/stubby/lib/stubby_mixin.rb", "test/fixtures/tmp", "test/fixtures/tmp/test.log", "test/rails_generators", "test/rails_generators/coulda_model_generator_test.rb", "test/shoulda_macros", "test/shoulda_macros/generator_macros.rb", "test/stolen_from_railties.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/hardbap/coulda}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Rails generators that create Shoulda & Factory Girl tests.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
