# Coulda generator

Inspired by [technicalpickles'](http://technicalpickles.com/) [shoulda\_generator](http://github.com/technicalpickles/shoulda_generator) (okay blatantly ripped off from ;)

What you'll need:

* [shoulda](http://github.com/thoughtbot/shoulda)
* [factory\_girl](http://github.com/thoughtbot/factory_girl)

## What is does

### coulda\_model

* a new model
* a migration (skip using --skip-migration option)
* a factory defined with [factory\_girl](http://github.com/thoughtbot/factory_girl) (skip using --skip-factory option)
* a [shoulda](http://github.com/thoughtbot/shoulda) unit test with some tests


### coulda\_scaffold

* a coulda\_model
* a RESTful controller
* a helper
* ERB template
* a shoulda functional test using a [factory\_girl](http://github.com/thoughtbot/factory_girl) factory


## Example usage

Use these just like the standard Rails generators.
    $ script/generate coulda\_model post title:string body:text published:boolean
    $ script/generate coulda\_scaffold post title:string body:text published:boolean
    
    
## Other stuff

### belongs\_to

Using "belongs\_to" as the field type for your coulda\_model will give you some extras.

* "add_index" in the migration
* "belongs\_to" in the model
* "should\_belong\_to" in unit test
* association in the factory

### example

    $ script/generate coulda\_model post title:string body:text user:belongs_to
    
will give you this migration:

    class CreatePosts < ActiveRecord::Migration
      def self.up
        create_table :posts do |t|
          t.string :title
          t.text :body
          t.belongs_to :user
          
          t.timestamps
        end

        add_index :posts, :user_id
      end

      def self.down
        remove_index :posts, :user_id
        drop_table :posts
      end
    end
    
for this model:

    class Post < ActiveRecord::Base
      belongs_to :user
    end
    
with this unit test:

    require File.dirname(__FILE__) + '/../test_helper'

    class PostTest < ActiveSupport::TestCase
  
      should_have_db_column :title, :type => "string"
      should_have_db_column :body, :type => "text"
      
      should_belong_to :user
      should_have_index :user_id
      
    end
    
and finally our factory:

    Factory.define :post do |f|
      f.title 'MyString'
      f.body 'MyString'
      f.user {|f| f.association(:user)}
    end