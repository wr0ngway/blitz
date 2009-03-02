class <%= class_name %>Controller < ApplicationController
<% resource       = file_name.singularize -%>
<% resources      = file_name.pluralize -%>
<% resource_class = class_name.singularize -%>

<% if actions.include?("index") -%>
  def index
  end

<% end -%>
<% if actions.include?("new") -%>
  def new
    @<%= resource %> = <%= resource_class %>.new
  end

<% end -%>
<% if actions.include?("create") -%>
  def create
    @<%= resource %> = <%= resource_class %>.new(params[:<%= resource %>])
    @<%= resource %>.save
    flash[:success] = '<%= resource_class %> created.'
    redirect_to <%= resources %>_path
  end

<% end -%>
<% if actions.include?("show") -%>
  def show
    @<%= resource %> = <%= resource_class %>.find(params[:id])
  end

<% end -%>
end
