class CreateBands < ActiveRecord::Migration[5.0]
  def change
    create_table :bands do |t|
      t.string :name,             null: false, default: ""
      t.string :musical_genre,    null: false, default: "Rock"

      t.references :band_manager, references: :users

      t.string :description
      t.string :nation
      t.string :region

      t.timestamps
    end
  end
end
