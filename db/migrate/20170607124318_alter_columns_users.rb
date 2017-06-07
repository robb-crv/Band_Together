class AlterColumnsUsers < ActiveRecord::Migration[5.0]
  def change
  	remove_column :users, :type_of_musician, :string
  	remove_column :users, :musical_genre, :string
  	add_column :users, :type_of_musician_id, :integer
  	add_column :users, :musical_genre_id, :integer
  end
end
