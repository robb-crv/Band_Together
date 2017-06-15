class BandConversation < ApplicationRecord
  belongs_to :band
  belongs_to :conversation, class_name: "Mailboxer::Conversation", foreign_key: "conversation_id"
end
