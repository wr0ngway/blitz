class <%= class_name %> < ActiveRecord::Base

  # includes: mixed in behavior

  # properties: attributes, associations
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %>
<% end -%>

  # lifecycle: validations, callbacks

  # class methods: self.method, named_scopes

  # instance methods

  # non-public interface: protected helpers

end
