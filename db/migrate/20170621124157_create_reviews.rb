class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
    	t.integer :reviewer_id
    	t.integer :reviewed_id
    	t.text    :description
    	t.integer :rating
      	t.timestamps
    end

    add_index :reviews, :reviewer_id
    add_index :reviews, :reviewed_id
  end
end
