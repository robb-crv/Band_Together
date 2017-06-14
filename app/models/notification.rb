class Notification < ApplicationRecord
   belongs_to :recipient, class_name: "User"
   belongs_to :actor, class_name: "User"
   belongs_to :notifiable, polymorphic: true

   scope :unread, ->{where read_at: nil}

   def label
     "#{actor.username} #{action}"
   end


   def url
     case notifiable.class
       when Mailboxer::Conversation.class
             "/conversations/#{notifiable.id}"
           else
             '#'
       end
   end


end
