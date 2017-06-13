class MailboxController < ApplicationController
  before_action :authenticate_user!

 def inbox
   @inbox = mailbox.inbox
   @mailboxer_active = :inbox
 end

 def sent
   @sent = mailbox.sentbox
   @mailboxer_active = :sent
 end

 def trash
   @trash = mailbox.trash
   @mailboxer_active = :trash
 end
end
