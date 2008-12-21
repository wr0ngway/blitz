# Coulda generator

Inspired by [technicalpickles'](http://technicalpickles.com/) [shoulda\_generator](http://github.com/technicalpickles/shoulda_generator) (okay blatantly ripped off from ;)

What you'll need:

* [shoulda](http://github.com/thoughtbot/shoulda)
* [factory\_girl](http://github.com/thoughtbot/factory_girl)

## What it does

### coulda\_model

* a new model
* a migration (skip using --skip-migration)
* a factory defined with [factory\_girl](http://github.com/thoughtbot/factory_girl) (skip using --skip-factory)
* a [shoulda](http://github.com/thoughtbot/shoulda) unit test with some tests


### coulda\_scaffold

* a coulda\_model
* a RESTful controller
* a helper
* ERB templates
* a [shoulda](http://github.com/thoughtbot/shoulda) functional test using a [factory\_girl](http://github.com/thoughtbot/factory_girl) factory
* a helper test in test/unit/helper


## Example usage

Use these just like the standard Rails generators.

    $ script/generate coulda_model post title:string body:text published:boolean
    $ script/generate coulda_scaffold post title:string body:text published:boolean
    
    
## Other stuff

### belongs\_to

Using "belongs\_to" as the field type provides some extra goodness.

* "add\_index" in the migration
* "belongs\_to" in the model
* "should\_belong\_to" in unit test
* association in the factory

### example

    $ script/generate coulda_model post title:string body:text user:belongs_to
    
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

## Authors

Mike Breen and [Dan Croak](http://github.com/dancroak)

## License

The MIT License
 
Copyright (c) 2008 Mike Breen
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.