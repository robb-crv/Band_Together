require 'rails_helper'



RSpec.describe Users::RegistrationsController , type: :controller do

include Devise::Test::ControllerHelpers


  describe "POST #create" do

    #situazioni in cui l'utente inserisce delle credenziali già utilizzate
      context "When user is already registered" do
=begin andrea fallisce!
        it "should redirect user to sign up page" do
          #fake user registrato nel db
          registeredUser = create(:user, email: "alreadytaken@domain.com" )

          userToCheck = build(:user,email: "alreadytaken@domain.com" )

          @request.env["devise.mapping"] = Devise.mappings[:user]
          sign_up :userToCheck



        end
=end

      end

    #situazioni in cui l'utente inserisce delle credenziali nuove
      context "When user is not registered yet" do

        #se l'utente inserisce parametri riconosciuti corretti dal model, allora
        #   deve caricare la user home page
        it "should redirect user to user home page" do

        end

        #se l'utente inserisce dei parametri errati allora deve caricare la sign up page
        it "should redirect user to sign up page" do

        end
      end
  end



end
