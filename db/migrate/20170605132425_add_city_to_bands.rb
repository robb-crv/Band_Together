class AddCityToBands < ActiveRecord::Migration[5.0]
  def change
    add_column :bands, :city, :string
  end
end
