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
<% if actions.include?("create") -%>
  def create
    @<%= file_name.singularize %> = <%= class_name.singularize %>.new(params[:<%= file_name.singularize %>])
    @<%= file_name.singularize %>.save
    flash[:success] = '<%= class_name.singularize %> created.'
    redirect_to <%= file_name %>_path
  end

<% end -%>
end
