class AlterColumnUsersBanned < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :users, :banned, false
  end
end
