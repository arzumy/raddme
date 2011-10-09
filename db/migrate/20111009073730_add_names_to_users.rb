class AddNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :family, :string
    add_column :users, :given, :string
    add_column :users, :prefix, :string
    add_column :users, :fullname, :string
  end
end