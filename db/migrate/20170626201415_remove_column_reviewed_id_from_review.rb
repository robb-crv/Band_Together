class RemoveColumnReviewedIdFromReview < ActiveRecord::Migration[5.0]
  def change
  	remove_column :reviews, :reviewed_id
  end
end
