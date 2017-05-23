class CreateAdvertisments < ActiveRecord::Migration[5.0]
  def change
    create_table :advertisments do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :term_date

      t.timestamps
    end
  end
end
