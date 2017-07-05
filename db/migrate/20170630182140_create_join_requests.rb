class CreateJoinRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :join_requests do |t|
    	t.integer :band_id
    	t.integer :sender_id
    	t.integer :receiver_id
    	t.boolean :pending
    	t.timestamps
    end

    add_index :join_requests, :band_id
    add_index :join_requests, :sender_id
    add_index :join_requests, :receiver_id
    add_index :join_requests, [:band_id, :sender_id, :receiver_id, :pending], unique: true
  end
end
