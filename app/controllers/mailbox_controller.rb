class MailboxController < ApplicationController
  before_action :authenticate_user!

 def inbox
   @folder = mailbox.inbox.or mailbox.sentbox
   @mailboxer_active = :inbox

   @bands = Band.active_bands_for(current_user)

   @selected_band = Band.find(params[:selected_band_id])

 end


 def trash
   @folder = mailbox.trash
   @mailboxer_active = :trash

  @bands = Band.active_bands_for(current_user)
 end
end
