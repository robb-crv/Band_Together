class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @folder = mailbox.inbox.or mailbox.sentbox
    @mailboxer_active = :inbox
  end


  def create
    recipients = User.where(id: conversation_params[:recipients])
    conversation = current_user.send_message(recipients, conversation_params[:body], conversation_params[:subject]).conversation
=begin
    band = current_user.bands.first
    band.conversations << conversation
=end

    #flash[:success] = "Your message was successfully sent!"

    #andrea. crea la notifica per gli utenti destinatari, salvando il riferimento alla conversazione.
    recipients.each do |usr|
        Notification.create(recipient: usr, actor: current_user, action: "has just sent a new message in the conversation '#{conversation.subject}'!", notifiable: conversation)
    end

  #  redirect_to controller: 'conversation', action: 'show', id: conversation.id, folder: @mailboxer_active

    redirect_to conversation_path( conversation,:folder => "inbox")
  end

  def show
    @recipients = conversation.recipients
    @receipts = conversation.receipts_for(current_user)

    folder = params[:folder]
    if folder == "trash"
      @folder = mailbox.trash
      @mailboxer_active = :trash

    else
      @folder = mailbox.inbox.or mailbox.sentbox
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
    params.require(:conversation).permit(:subject, :body,recipients:[])
  end

  def message_params
    params.require(:message).permit(:body, :subject)
  end

end
