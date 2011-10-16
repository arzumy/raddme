class AddCustomMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :custom_message, :text
  end
end
