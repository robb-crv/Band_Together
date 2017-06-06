class CreateMemberAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :member_associations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :joined_band, class_name: "Band", index: true
      t.timestamps
    end
  end
end
