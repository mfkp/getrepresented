class CreateResponses < ActiveRecord::Migration
  def self.up
    create_table :responses do |t|
      t.references :post
      t.references :member
      t.text :response
      t.datetime :created_at
      t.timestamps
    end
  end

  def self.down
    drop_table :responses
  end
end
