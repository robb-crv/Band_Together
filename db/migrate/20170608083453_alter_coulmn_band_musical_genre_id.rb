class AlterCoulmnBandMusicalGenreId < ActiveRecord::Migration[5.0]
  def change
  	change_column :bands, :musical_genre_id, :integer, :default => "0"
  end
end
