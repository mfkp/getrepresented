class AddProfileFieldsToMembers < ActiveRecord::Migration
  def self.up
    add_column "members", "first_name", :string
    add_column "members", "last_name", :string
    add_column "members", "profile", :text
  end

  def self.down
    remove_column "members", "first_name"
    remove_column "members", "last_name"
    remove_column "members", "profile"
  end
end