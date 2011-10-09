class AddNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string
    add_column :users, :street, :string
    add_column :users, :locality, :string
    add_column :users, :country, :string
    add_column :users, :postalcode, :string
    add_column :users, :phone_mobile, :string
    add_column :users, :phone_work, :string
    add_column :users, :phone_fax, :string
    add_column :users, :title, :string
    add_column :users, :organization, :string
  end
end