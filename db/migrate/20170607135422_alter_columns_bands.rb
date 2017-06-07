class AlterColumnsBands < ActiveRecord::Migration[5.0]
  def change
  	remove_column :bands, :musical_genre, :string
  	add_column :bands, :musical_genre_id, :integer
  end
end
