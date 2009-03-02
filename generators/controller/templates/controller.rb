class <%= class_name %>Controller < ApplicationController
<% if actions.include?("index") -%>
  def index
  end

<% end -%>
<% if actions.include?("new") -%>
  def new
    @<%= file_name.singularize %> = <%= class_name.singularize %>.new
  end

<% end -%>
end
