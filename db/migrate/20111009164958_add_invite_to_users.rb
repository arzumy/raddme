class AddInviteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invite_token, :string
  end
end
