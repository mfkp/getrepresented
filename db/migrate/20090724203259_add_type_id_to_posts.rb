class AddTypeIdToPosts < ActiveRecord::Migration
  def self.up
    add_column "posts", "type_id", :integer
  end
 
  def self.down
    remove_column "posts", "type_id"
  end
end
