class Notification < ApplicationRecord
   belongs_to :recipient, class_name: "User"
   belongs_to :actor, class_name: "User"
   belongs_to :notifiable, polymorphic: true

   scope :unread, ->{where read_at: nil}

   def label
     "#{actor.username} #{action}"
   end


   def url
     case notifiable

        when Band
          "/bands/#{notifiable.id}"

        when User
          "/users/show?id=#{notifiable.id}"

        when Mailboxer::Conversation
          "/conversations/#{notifiable.id}"

        else
          '#'
       end
   end





   class  TypeValidator < ActiveModel::EachValidator

     def validate_each(record, attribute, value)
       record.errors.add attribute, "Not a valid notifiable type" unless ["Mailboxer::Conversation","User","Band"].include? value
     end
   end

   class UserValidator < ActiveModel::EachValidator
     def validate_each(record, attribute, value)
       record.errors.add attribute, "It's not a valid user" unless !User.find_by_id(value).nil?
     end
   end

   def notifiable_exists
     case notifiable_type

      when "Band"

          errors.add(:notifiable_id, "It's not a valid band") unless !Band.find_by_id(notifiable_id).nil?
      when "User"

          errors.add(:notifiable_id, "It's not a valid user") unless !User.find_by_id(notifiable_id).nil?

      when "Mailboxer::Conversation"

          errors.add(:notifiable_id, "It's not a valid conversation") unless !Mailboxer::Conversation.find_by_id(notifiable_id).nil?
      else

          nil
       end
   end

   validate :notifiable_exists
   validates :recipient_id, presence: true, allow_nil:false,user:true
   validates :actor_id, presence: true, allow_nil:false,user:true
   validates_date :read_at, allow_blank: false, allow_nil: true, :before => lambda{Date.current}
   validates :action, presence: true,allow_blank: false, allow_nil: false
   validates :notifiable_id, presence: true, allow_nil:false
   validates :notifiable_type, presence: true, allow_nil:false, allow_blank: false, type:true



end
