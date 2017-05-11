class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2,:facebook]

  include ActiveModel::Validations

  #Custom Validators

		#Type of musician validation

class  TypeValidator < ActiveModel::EachValidator

      def validate_each(record, attribute, value)

        record.errors.add attribute, "Non è un tipo di musicista supportato" unless ["Drummer", "Lead_guitarist", "Rhythmic_guitarist", "Bass_guitarist", "Keyboardist", "Singer", "Winds", ""].include? value
      end
  end

    #Musical genre validation

  class  GenreValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      record.errors.add attribute, "Non è un genere musicale supportato" unless ["Rock", "Metal", "Jazz", "Blues", "Pop", "Classic", "Latin", ""].include? value
    end
  end
  
   #Nation validation

  	class  NationValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
      		record.errors.add attribute, "Non è una nazione valida" unless CS.countries.has_value? value      
    	end
  	end
  

    #Region validation

  	class  RegionValidator < ActiveModel::EachValidator

    	def validate_each(record, attribute, value)
      	record.errors.add attribute, "Non è una regione valida" unless CS.states(CS.countries.key(record.nation)).has_value? value      
    	end
  	end
	#Validations

=begin

 Ho dovuto mettere il constraint allow_nil su tutte le validazioni (a parte dell'email) per far sì che un utente si potesse autenticare la prima volta tramite google
 oauth. Infatti tramite oauth la maggior parte dei campi non possono essere riempiti al momento della sign in / registrazione, ma saranno riempiti in un secondo momento
 dall'utente nella sua pagina delle impostazioni del profilo (PAGINA DA AGGIUNGERE). Allow_nil fa sì che il sistema accetti un valore nullo. Ciò però non contrasta la
 validazione della presenza del campo durante la sign in propria della nostra applicazione (ovvero, in ogni caso non accetta campi blank NELLE FORM, ma accetta che quando
 si invoca la create non vengano passati tutti gli attributi)

 RezeR

=end

	before_save { email.downcase! }
	#Stringa composta da caratteri alfanumerici, underscore, dash, "+"" e "."
	VALID_USERNAME_REGEX = /\A[\w+\-.]+\z/i
  validates :username, presence: true, length: {maximum: 64}, format: {with: VALID_USERNAME_REGEX}, uniqueness: {case_sensitive: false}
	#LA VALIDAZIONE DELL'EMAIL VIENE GESTITA DA DEVISE 
	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z\d\-.]+\z/i
	#validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	VALID_NAME_REGEX = /\A[A-Z]'?[- a-zA-Z]+( [a-zA-Z])*\z/
	validates :first_name, allow_blank: false, length: {maximum: 50}, format: {with: VALID_NAME_REGEX}, allow_nil: true
	validates :last_name, allow_blank: false, length: {maximum: 50}, format: {with: VALID_NAME_REGEX}, allow_nil: true
	validates_date :birth, allow_blank: false, allow_nil: true, :after => '1900-1-1', :before => lambda{Date.current}
	validates :nation, allow_blank: false, length: {maximum: 50}, nation: true, allow_nil: true
	validates :region, allow_blank: false, length: {maximum: 50}, allow_nil: true, region: true 
	VALID_GENDER_REGEX = /[MF]/
	validates :gender, allow_blank: false, length: {maximum: 1}, format: {with: VALID_GENDER_REGEX}, allow_nil: true
  validates :type_of_musician, length: {maximum: 50}, type: true, allow_nil: true
  validates :musical_genre, length: {maximum: 50}, genre: true, allow_nil: true


  #Metodo utilizzato per l'autorizzazione dell'utente tramite google
  def self.find_for_google_oauth2(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info["email"]
      user.username = auth.info["email"].split("@").first
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.find_for_facebook(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.username = auth.info.email.split("@").first
      user.password = Devise.friendly_token[0,20]
    end
  end

end
