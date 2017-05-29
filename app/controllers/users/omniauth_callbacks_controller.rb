class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]



  def facebook

    #to_create = User.find_for_email(request.env["omniauth.auth"])   #andrea. indica se deve essere mandata la mail di cambio password
    @user = User.find_for_facebook(request.env["omniauth.auth"])

    if !@user
        session["devise.facebook_data"] = request.env["omniauth.auth"].except[:extra]
        redirect_to new_user_registration_path
        #andrea. usa il file config/locales/devise.en.yml
        flash[:error] = t("devise.omniauth_callbacks.failure",:kind => "Facebook", :reason => "the email you are using already exists. Please Sign Up first")
      else
        if @user.persisted?
=begin
          if to_create
            @user.send_reset_password_instructions     #andrea. funzione di devise, manda email di reset passsword
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
            flash[:error] = t("devise.unlocks.send_paranoid_instructions")
            redirect_to root_path
          else
=end
            sign_in_and_redirect @user, :event => :authentication
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
          #end
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_path
        end
      end
  end



  def google_oauth2
      #to_create = User.find_for_email(request.env["omniauth.auth"])   #andrea. indica se deve essere mandata la mail di cambio password
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"])
      if !@user
          session["devise.google"] = request.env["omniauth.auth"].except[:extra]
          redirect_to new_user_registration_path
          #andrea. usa il file config/locales/devise.en.yml
          flash[:error] = t("devise.omniauth_callbacks.failure",:kind => "Google", :reason => "the email you are using already exists. Please Sign Up first")
        else
          if @user.persisted?
=begin
            if to_create
              @user.send_reset_password_instructions     #andrea. funzione di devise, manda email di reset passsword
              set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
              flash[:error] = t("devise.unlocks.send_paranoid_instructions")
              redirect_to root_path
            else
=end
              sign_in_and_redirect @user, :event => :authentication
              set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
        #    end
=begin
          else

              session["devise.google"] = request.env["omniauth.auth"]
              redirect_to new_user_registration_path
=end
          end
      end
  end

  def failure
    flash[:error] = t("devise.omniauth_callbacks.failure",:kind => "service", :reason => "credentials aren't correct. Please Sign Up first")
    redirect_to request.referer
end
  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
