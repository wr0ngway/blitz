Then /^the paperclip migration should add "(.*)" columns to the "(.*)"$/ do |attr, table|
  up   = "      add_column :#{table}, :#{attr}_file_name,    :string\n"  <<
         "      add_column :#{table}, :#{attr}_content_type, :string\n"  <<
         "      add_column :#{table}, :#{attr}_file_size,    :integer\n" <<
         "      add_column :#{table}, :#{attr}_updated_at,   :datetime"
  down = "      remove_column :#{table}, :#{attr}_file_name\n"    <<
         "      remove_column :#{table}, :#{attr}_content_type\n" <<
         "      remove_column :#{table}, :#{attr}_file_size\n"    <<
         "      remove_column :#{table}, :#{attr}_updated_at"
  assert_generated_migration(table) do |body|
    assert body.include?(up), body.inspect
    assert body.include?(down), body.inspect
  end
end

Then /^the "(.*)" table should have db index on "(.*)"$/ do |table, foreign_key|
  assert_generated_migration(table) do
    "add_index :#{table}, :#{foreign_key}"
  end
end

Then /^the "(.*)" table should have paperclip columns for "(.*)"$/ do |table, attr|
  assert_generated_migration(table) do
    "      table.string :#{attr}_file_name\n"    <<
    "      table.string :#{attr}_content_type\n" <<
    "      table.integer :#{attr}_file_size\n"   <<
    "      table.datetime :#{attr}_updated_at"
  end
end

