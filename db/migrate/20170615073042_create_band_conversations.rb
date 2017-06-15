class CreateBandConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :band_conversations do |t|
      t.column :band_id, :integer, :null => false
      t.column :conversation_id, :integer, :null => false
      t.timestamps
    end
  end
end
