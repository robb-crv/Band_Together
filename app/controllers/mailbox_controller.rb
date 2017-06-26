class MailboxController < ApplicationController
  before_action :authenticate_user!


 def inbox
  # @folder = mailbox.inbox.or mailbox.sentbox
   @mailboxer_active = :inbox

   @bands = Band.active_bands_for(current_user)

   if params[:selected_band_id]
     @selected_band = Band.find(params[:selected_band_id])
     @folder = @selected_band.conversations.not_trash(current_user)
   else
     @selected_band = nil
     @folder = (mailbox.inbox.or (mailbox.sentbox)).where(band_id: nil)
   end

 end


 def trash
   @folder = mailbox.trash
   @mailboxer_active = :trash

   @bands = Band.active_bands_for(current_user)
 end
end
