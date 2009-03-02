require 'test_helper'

class <%= class_name %>ControllerTest < ActionController::TestCase

<% if actions.include?("index") -%>
  context 'GET to index' do
    setup { get :index }

    should_respond_with :success
    should_render_template :index
  end

<% end -%>
<% if actions.include?("new") -%>
  context 'GET to new' do
    setup { get :new }

    should_respond_with :success
    should_render_template :new
    should_assign_to :<%= file_name %>
  end

<% end -%>
<% if actions.include?("create") -%>
  context 'POST to create' do
    setup do
      post :create, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>)
      @<%= file_name %> = <%= class_name %>.find(:all).last
    end

    should_redirect_to '<%= file_name %>_path(@<%= file_name %>)'
  end

<% end -%>
<% if actions.include?("show") -%>
  context 'GET to show' do
    setup do
      @<%= file_name %> = Factory(:<%= file_name %>)
      get :show, :id => @<%= file_name %>.id
    end

    should_respond_with :success
    should_render_template :show
    should_assign_to :<%= file_name %>
  end

<% end -%>
<% if actions.include?("edit") -%>
  context 'GET to edit' do
    setup do
      @<%= file_name %> = Factory(:<%= file_name %>)
      get :edit, :id => @<%= file_name %>.id
    end

    should_respond_with :success
    should_render_template :edit
    should_assign_to :<%= file_name %>
  end

<% end -%>
<% if actions.include?("update") -%>
  context 'PUT to update' do
    setup do
      @<%= file_name %> = Factory(:<%= file_name %>)
      put :update, :id => @<%= file_name %>.id, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>)
    end

    should_redirect_to '<%= file_name %>_path(@<%= file_name %>)'
  end

<% end -%>
<% if actions.include?("destroy") -%>
  context 'DELETE to destroy' do
    setup do
      @<%= file_name %> = Factory(:<%= file_name %>)
      delete :destroy, :id => @<%= file_name %>.id
    end

    should_redirect_to '<%= table_name %>_path'
  end

<% end -%>
end

