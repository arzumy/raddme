class AddOrganizationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_company, :boolean, default: false
    User.update_all(is_company: false)
  end
end
