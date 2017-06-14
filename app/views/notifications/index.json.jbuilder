json.notifications @notifications do |notification|

  json.etichetta notification.label
   case notification.notifiable.class
   when Mailboxer::Conversation.class
         json.url "/conversations/#{notification.notifiable.id}"
       else
         json.url '#'
   end
end
