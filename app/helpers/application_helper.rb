module ApplicationHelper
  def uri_without_flash_messages
     [users_edit_profile_informations_path, edit_user_registration_path]
  end

  def button_class_active_recipient(active_page)
    @mailboxer_active == active_page ? "btn btn-primary" : "btn btn-notice"
  end
end
