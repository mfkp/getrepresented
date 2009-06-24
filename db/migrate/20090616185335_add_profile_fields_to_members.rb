class AddProfileFieldsToMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.timestamps
    end
    add_column "members", "first_name", :string
    add_column "members", "last_name", :string
    add_column "members", "profile", :text
  end

  def self.down
    drop_table :members
    remove_column "members", "first_name"
    remove_column "members", "last_name"
    remove_column "members", "profile"
  end
end