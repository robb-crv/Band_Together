class AddBandIdToConversations < ActiveRecord::Migration[5.0]
  def change

      add_column :mailboxer_conversations, :band_id, :integer
  end
end
