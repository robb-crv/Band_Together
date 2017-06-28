class AddReviewableReferencesToReview < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :reviewable, polymorphic: true, index: true 
  end
end
