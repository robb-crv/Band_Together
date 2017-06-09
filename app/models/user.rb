class User < ApplicationRecord 
  # Include default devise modules. Others available are:

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable, :omniauth_providers => [:google_oauth2,:facebook]

  #association
  has_many :bands, dependent: :destroy, foreign_key: 'band_manager_id'
  has_many :advertisment, dependent: :destroy, foreign_key: 'user_id'

  #andrea association for band member
  has_many :member_associations, :dependent => :delete_all, :foreign_key => "user_id"
  has_many :joined_bands, class_name: "Band",  through: :member_associations

  #attr_accessor :remember_token
  include ActiveModel::Validations

#SEARCH ENGINE PARAMETER DEFINITIONS

  # Include integration with searchkick
  searchkick

  def search_data
    {
      username: username,
      nation: nation,
      region: region,
      city: city
      #type_of_musician_id: type_of_musician_id,
      #musical_genre_id: musical_genre_id 
    }
  end
  
#CUSTOM VALIDATORS

=begin

  #Type of musician validation

  class  TypeValidator < ActiveModel::EachValidator

      def validate_each(record, attribute, value)

        record.errors.add attribute, "Not a supported musician type" unless TypeOfMusician.find_by_id == value
      end
  end

  #Musical genre validation

  class  GenreValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      record.errors.add attribute, "Not a supported musical genre" unless ["Rock", "Metal", "Jazz", "Blues", "Pop", "Classic", "Latin", ""].include? value
    end
  end

=end

   #Nation validation

   class  NationValidator < ActiveModel::EachValidator

     def validate_each(record, attribute, value)
         record.errors.add attribute, "Not a valid Nation" unless CS.countries.has_value? value
     end
   end


   #Region validation

   class  RegionValidator < ActiveModel::EachValidator

     def validate_each(record, attribute, value)
       record.errors.add attribute, "Not a valid Region" unless CS.states(CS.countries.key(record.nation)).has_value? value
     end
   end

   class  CityValidator < ActiveModel::EachValidator

     def validate_each(record, attribute, value)
       record.errors.add attribute, "Not a valid City" unless CS.cities(CS.states(CS.countries.key(record.nation)).key(record.region),CS.countries.key(record.nation)).include? value
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
  validates :city, allow_blank: false, length: {maximum: 50}, allow_nil: true, city: true
	VALID_GENDER_REGEX = /[MF]/
	validates :gender, allow_blank: false, length: {maximum: 1}, format: {with: VALID_GENDER_REGEX}, allow_nil: true
  #validates :type_of_musician_id, allow_nil: true
  #validates :musical_genre_id, allow_nil: true


  #Metodo utilizzato per l'autorizzazione dell'utente tramite google
  def self.find_for_google_oauth2(auth)
    if user = User.where(email: auth['info']['email']).first      #andrea. controllo se esiste già un utente con la stessa mail.
        if user.provider == auth.provider
          #puts "PROVIDER UGUALE"
          user
        else
          #puts "PROVIDER DIVERSO"
          #andrea. se l'utente si è già registrato al sito web tramite un provider che non sia
            #       uguale a google in questo caso allora dare errore.
          return nil
        end
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
        user.email = auth.info["email"]
        user.username = auth.info["email"].split("@").first
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
      end
    end
  end

#andrea, ritorna un boolean, che indica se l'user è da creare. Serve per mandare la mail
def self.find_for_email(auth)
    if user = User.where(email: auth['info']['email']).first
      return false
    else
      return true
    end
end


  def self.find_for_facebook(auth)
    if user = User.where(email: auth['info']['email']).first      #andrea. controllo se esiste già un utente con la stessa mail.
        if user.provider == auth.provider
          #puts "PROVIDER UGUALE"
         return user
        else
          #puts "PROVIDER DIVERSO"
          #andrea. se l'utente si è già registrato al sito web tramite un provider che non sia
            #       uguale a facebook in questo caso allora dare errore.
          return nil
        end
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|

        user.email = auth.info.email
         user.username = auth.info.email.split("@").first
        user.password = Devise.friendly_token[0,20]
         user.first_name = auth.info["first_name"]
         user.last_name = auth.info["last_name"]
        user.skip_confirmation!
      end
    end
  end


  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Override del metodo di devise che controlla se un utente è attivo per l'autenticazione
  # In questo modo controlla se l'utente è bannato prima di autenticarlo

  def active_for_authentication?
    super && !self.banned
  end

  # Override del metodo inactive_message di Devise che cambia il messaggio di errore quando l'utente è bannto in
  # "Your account is locked"

  def inactive_message
    !self.banned ? super : :locked
  end

end
