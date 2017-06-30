class BandConversation < ApplicationRecord
  belongs_to :band
  belongs_to :conversation, class_name: "Mailboxer::Conversation", foreign_key: "conversation_id"



  class ConversationValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors.add attribute, "It's not a valid conversation" unless !Mailboxer::Conversation.find_by_id(value).nil?
    end
  end

  class BandValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors.add attribute, "It's not a valid band" unless !Band.find_by_id(value).nil?
    end
  end



  validates :band_id , presence: true, allow_nil: false, band: true
  validates :conversation_id , presence: true, allow_nil: false, conversation: true

  validates_uniqueness_of :conversation_id, scope: :band_id

end
