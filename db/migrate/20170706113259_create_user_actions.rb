class CreateUserActions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_actions do |t|
      t.integer :sender_id
      t.string :sender_type
      t.string :action
      t.integer :receiver_id
      t.string :receiver_type
      t.timestamps
    end
  end
end
