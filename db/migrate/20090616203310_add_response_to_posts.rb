class AddResponseToPosts < ActiveRecord::Migration
  def self.up
    add_column "posts", "response", :text
  end

  def self.down
    remove_column "posts", "response"
  end
end
