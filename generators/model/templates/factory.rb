Factory.define :<%= file_name %> do |<%= file_name %>|
<% attributes.each do |attribute| -%>
  <%= file_name -%>.<%= attribute.name %> <%= attribute.default_for_factory %>
<% end -%>
end
