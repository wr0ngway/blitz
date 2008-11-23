Factory.define :<%= file_name %> do |f|
<% for attribute in attributes -%>
  <%= factory_line(attribute) %>
<% end -%>
end