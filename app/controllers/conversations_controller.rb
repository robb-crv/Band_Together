class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @folder = mailbox.inbox.or mailbox.sentbox
    @mailboxer_active = :inbox



     @bands = Band.active_bands_for(current_user)
  end


  def create
    if conversation_params[:band] != nil
      band = Band.find(conversation_params[:band])
      recipients = band.active_users
      recipients.delete current_user  #cancella l'user corrente perchè a lui non si deve mandare un messaggio
    else
      recipients = User.where(id: conversation_params[:recipients])
    end

    conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
    if conversation.nil?
      flash[:danger] = "Couldn't send message, please retry."
      redirect_to new_conversation_path
    end

    recipients.each do |usr|
        Notification.create(recipient: usr, actor: current_user, action: "has just sent a new message in the conversation '#{conversation.subject}'!", notifiable: conversation)
    end

    if conversation_params[:band] != nil
      band.conversations << conversation
      conversation.band_id = band.id
      conversation.save
    end

    redirect_to conversation_path( conversation,:folder => "inbox")
  end


  def show
    @recipients = conversation.recipients
    @receipts = conversation.receipts_for(current_user)

     @bands = Band.active_bands_for(current_user)

    folder = params[:folder]
    if folder == "trash"
      @folder = mailbox.trash
      @mailboxer_active = :trash
    else
      if conversation.band_id.nil?
        @selected_band = nil
        @folder = (mailbox.inbox.or (mailbox.sentbox)).where(band_id: nil)
      else
        @selected_band = Band.find(conversation.band_id)
        @folder = @selected_band.conversations.not_trash(current_user)
      end
      @mailboxer_active = :inbox
    end

    conversation.mark_as_read(current_user)
  end

  def reply
   current_user.reply_to_conversation(conversation, message_params[:body])

   conversation.recipients.each do |usr|
       if usr != current_user
         Notification.create(recipient: usr, actor: current_user, action: "has just replied in the conversation '#{conversation.subject}'!", notifiable: conversation)
       end
    end

  # flash[:notice] = "Your reply message was successfully sent!"
   redirect_to conversation_path(conversation)
  end


  def trash
    conversation.move_to_trash(current_user)
    redirect_to mailbox_inbox_path
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to mailbox_trash_path
  end



  private

  def conversation_params
    params.require(:conversation).permit(:band, :subject, :body,recipients:[])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end

end
