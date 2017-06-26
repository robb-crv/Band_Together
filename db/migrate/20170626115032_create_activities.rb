class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.references :band_manager, references: :users
      t.references :band, references: :bands
      t.column  :date, :datetime
      t.column  :description, :string
      t.column  :accessibility, :string
      t.timestamps
    end
  end
end
