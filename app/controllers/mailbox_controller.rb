class MailboxController < ApplicationController
  before_action :authenticate_user!

 def inbox
   @folder = mailbox.inbox.or mailbox.sentbox
   @mailboxer_active = :inbox
 end


 def trash
   @folder = mailbox.trash
   @mailboxer_active = :trash
 end
end
