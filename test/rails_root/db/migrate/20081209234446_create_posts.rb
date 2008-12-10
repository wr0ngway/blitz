class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |table|
      table.string :title
      table.text :body
      table.belongs_to :user

      table.timestamps
    end
    
    add_index :posts, :user_id
  
  end

  def self.down
    remove_index :posts, :user_id

    drop_table :posts
  end
end