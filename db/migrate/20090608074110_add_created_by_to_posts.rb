class AddCreatedByToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :created_by, :integer
  end

  def self.down
    remove_column :posts, :created_by
  end
end
