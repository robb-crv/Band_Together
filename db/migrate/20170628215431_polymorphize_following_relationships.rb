class PolymorphizeFollowingRelationships < ActiveRecord::Migration[5.0]
  def change
  	remove_column :following_relationships, :followed_id
  	add_reference :following_relationships, :followable, polymorphic: true, index: { :name => 'reference_followable' }
  	add_index :following_relationships, [:follower_id, :followable_type ,:followable_id ], unique: true,  :name => 'index_on_follower_followable_type'
  end
end
