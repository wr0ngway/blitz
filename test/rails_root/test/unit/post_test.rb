require File.dirname(__FILE__) + '/../test_helper'
 
class PostTest < ActiveSupport::TestCase
  
  should_have_db_column :title, :type => "string"
    
  should_have_db_column :body, :type => "text"
    
  should_belong_to  :user
  should_have_index :user_id
   
end