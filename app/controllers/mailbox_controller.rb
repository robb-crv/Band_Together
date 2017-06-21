class MailboxController < ApplicationController
  before_action :authenticate_user!


 def inbox
  # @folder = mailbox.inbox.or mailbox.sentbox
   @mailboxer_active = :inbox

   @bands = Band.active_bands_for(current_user)

   if params[:selected_band_id]
     @selected_band = Band.find(params[:selected_band_id])
     @folder = @selected_band.conversations
   else
     @selected_band = nil
     @folder = BandConversation.get_conversations_not_related_to_band_for(current_user)
   end

 end


 def trash
   @folder = mailbox.trash
   @mailboxer_active = :trash

   @bands = Band.active_bands_for(current_user)
 end
end
