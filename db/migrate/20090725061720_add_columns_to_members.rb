class AddColumnsToMembers < ActiveRecord::Migration
  def self.up
    add_column "members", "title", :string
    add_column "members", "party", :string
    add_column "members", "state", :string
    add_column "members", "district", :string
    add_column "members", "phone", :string
    add_column "members", "fax", :string
    add_column "members", "website", :string
    add_column "members", "office", :string
  end

  def self.down
    remove_column "members", "title"
    remove_column "members", "party"
    remove_column "members", "state"
    remove_column "members", "district"
    remove_column "members", "phone"
    remove_column "members", "fax"
    remove_column "members", "website"
    remove_column "members", "office"
  end
end
