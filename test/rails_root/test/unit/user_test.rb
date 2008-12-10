require File.dirname(__FILE__) + '/../test_helper'
 
class UserTest < ActiveSupport::TestCase
  
  should_have_db_column :name, :type => "string"
   
end