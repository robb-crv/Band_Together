class AddMusiciansToAdvertisments < ActiveRecord::Migration[5.0]
  def change
    add_column :advertisments, :musicians, :text
  end
end
