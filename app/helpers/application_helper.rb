module ApplicationHelper
  def uri_without_flash_messages
     [users_edit_profile_informations_path, edit_user_registration_path]
  end
end
