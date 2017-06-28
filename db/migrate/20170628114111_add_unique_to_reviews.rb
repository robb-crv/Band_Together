class AddUniqueToReviews < ActiveRecord::Migration[5.0]
  def change
      add_index :reviews, [:reviewable_id,:reviewable_type ,:reviewer_id ], unique: true,  :name => 'index_on_reviewer_reviewed_type'
  end
end
