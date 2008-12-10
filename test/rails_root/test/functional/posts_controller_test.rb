require File.dirname(__FILE__) + '/../test_helper'
 
class PostsControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup do
      get :index
    end
    should_respond_with :success
    should_assign_to :posts
  end
 
  context 'GET to new' do
    setup do
      get :new
    end
 
    should_respond_with :success
    should_render_template :new
    should_assign_to :post
  end
 
  context 'POST to create' do
    setup do
      post :create, :post => Factory.attributes_for(:post)
      @post = Post.find(:all).last
    end
    
    should_redirect_to 'post_path(@post)'
  end
 
  context 'GET to show' do
    setup do
      @post = Factory(:post)
      get :show, :id => @post.id
    end
    should_respond_with :success
    should_render_template :show
    should_assign_to :post
  end
 
  context 'GET to edit' do
    setup do
      @post = Factory(:post)
      get :edit, :id => @post.id
    end
    should_respond_with :success
    should_render_template :edit
    should_assign_to :post
  end
 
  context 'PUT to update' do
    setup do
      @post = Factory(:post)
      put :update, :id => @post.id, :post => Factory.attributes_for(:post)
    end
    should_redirect_to 'post_path(@post)'
  end
 
  context 'DELETE to destroy' do
    setup do
      @post = Factory(:post)
      delete :destroy, :id => @post.id
    end
    should_redirect_to 'posts_path'
  end
end