class BandConversation < ApplicationRecord
  belongs_to :band
  belongs_to :conversation, class_name: "Mailboxer::Conversation", foreign_key: "conversation_id"


  def self.get_conversations_not_related_to_band_for(user)
    Mailboxer::Conversation.participant(user)
  end
end
