class AddResponseToPosts < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
    end
    add_column "posts", "response", :text
  end

  def self.down
    drop_table :tags
    remove_column "posts", "response"
  end
end
