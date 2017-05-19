class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]



  def facebook
    @user = User.find_for_facebook(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_path
    end
  end



  def google_oauth2

      @user = User.find_for_google_oauth2(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication
        set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
      else
        session["devise.google"] = request.env["omniauth.auth"].except[:extra]
          redirect_to new_user_registration_path
      end
  end

  def failure

    redirect_to root_path
end
  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
