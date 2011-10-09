class AddUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :url, :string
    add_column :users, :slug, :string
    add_index :users, :slug, :unique => true
  end
end
