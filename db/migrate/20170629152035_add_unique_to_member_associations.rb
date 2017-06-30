class AddUniqueToMemberAssociations < ActiveRecord::Migration[5.0]
  def change
    add_index :member_associations, [:user_id,:joined_band_id ], unique: true,  :name => 'index_on_user_joined_band'
  end
end
