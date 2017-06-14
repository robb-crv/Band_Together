class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.column :recipient_id, :integer, :null => false
      t.column :actor_id, :integer
      t.column :read_at, :datetime
      t.column :action, :string
      t.column :notifiable_id, :integer
      t.column :notifiable_type, :string
      t.timestamps
    end
  end
end
