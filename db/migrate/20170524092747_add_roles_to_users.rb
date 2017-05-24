class AddRolesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin_role, :boolean, default: false
    add_column :users, :band_manager_role, :boolean, default: false
    add_column :users, :band_member_role, :boolean, default: false
    add_column :users, :user_role, :boolean, default: true
  end
end
