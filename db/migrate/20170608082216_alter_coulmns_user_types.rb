class AlterCoulmnsUserTypes < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :type_of_musician_id, :integer, :default => "0"
  	change_column :users, :musical_genre_id, :integer, :default => "0"
  end
end
