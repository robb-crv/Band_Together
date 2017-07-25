class User < ApplicationRecord
    after_create :send_welcome_notification
  # Include default devise modules. Others available are:

  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :confirmable, :omniauth_providers => [:google_oauth2,:facebook]


  #andrea. prepara il model per il modulo di messaggistica
  acts_as_messageable

  has_many :notifications, foreign_key: 'recipient_id', :dependent => :destroy
  has_many :active_notifications,class_name: 'Notification', foreign_key: 'actor_id', :dependent => :destroy
  has_many :passive_notifications,  -> {where :notifiable_type => "User"}, class_name: 'Notification', foreign_key: "notifiable_id", dependent: :destroy

  #association
  has_many :bands, dependent: :destroy, foreign_key: 'band_manager_id'
  has_many :advertisment, dependent: :destroy, foreign_key: 'user_id'


  #andrea association for band member
  has_many :member_associations, :foreign_key => "user_id", dependent: :destroy
  has_many :joined_bands, class_name: "Band",  through: :member_associations


  #FollowingRelationship
  has_many :active_relationships, class_name: "FollowingRelationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships,  -> {where :followable_type => "User"}, class_name: "FollowingRelationship", foreign_key: "followable_id", dependent: :destroy

  has_many :followings_bands, through: :active_relationships, source: :followable, source_type: 'Band'
  has_many :followings_users, through: :active_relationships, source: :followable, source_type: 'User'
  has_many :followers, through: :passive_relationships, source: :follower

  #Review
  has_many :active_reviews, class_name: 'Review', foreign_key: "reviewer_id", dependent: :destroy
  has_many :passive_reviews,  -> {where :reviewable_type => "User"}, class_name: 'Review', foreign_key: "reviewable_id", dependent: :destroy

  #has_many :reviewings_bands, through: :active_reviews, source: :reviewable, source_type: 'Band', dependent: :destroy
  #has_many :reviewings_users, through: :active_reviews, source: :reviewable, source_type: 'User', dependent: :destroy

  #has_many :reviewers, through: :passive_reviews, source: :reviewer, dependent: :destroy

  #JoinRequest
  has_many :active_join_request, class_name: "JoinRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :passive_join_request, class_name: "JoinRequest", foreign_key: "receiver_id", dependent: :destroy


  has_many :active_user_action, -> {where :sender_type => "User"}, class_name: "UserAction", foreign_key: "sender_id", dependent: :destroy
  has_many :passive_user_action, -> {where :receiver_type => "User"}, class_name: "UserAction", foreign_key: "receiver_id", dependent: :destroy

  #attr_accessor :remember_token
  include ActiveModel::Validations

#SEARCH ENGINE PARAMETER DEFINITIONS

  # Include integration with searchkick
  searchkick word_start: [:username, :email, :type_of_musician_name, :nation, :region, :city, :musical_genre_name]

  def search_data
    {
      username: username,
      email: email,
      nation: nation,
      region: region,
      city: city,
      type_of_musician_name: TypeOfMusician.find_by_id(type_of_musician_id).name,
      type_of_musician_id: type_of_musician_id,
      musical_genre_name: MusicalGenre.find_by_id(musical_genre_id).name,
      musical_genre_id: musical_genre_id,
      gender: gender,
      birth: birth
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

   class  GenreValidator < ActiveModel::EachValidator

      def validate_each(record, attribute, value)
          record.errors.add attribute, "Not a supported musical genre" unless ["Rock", "Metal", "Jazz", "Blues", "Pop", "Classic", "Latin", "Undefined", ""].include? MusicalGenre.find(value).name
      end
    end


    class  TypeValidator < ActiveModel::EachValidator

      def validate_each(record, attribute, value)
          record.errors.add attribute, "Not a supported type of musician" unless ["Drummer", "Lead guitarist", "Rhythmic guitarist", "Singer", "Winds", "Keyboardist", "Bass guitarist", "Rhythmic guitarist", "Undefined", ""].include? TypeOfMusician.find(value).name
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
  validates :musical_genre_id,  presence: true, allow_nil: false, genre: true
  validates :type_of_musician_id, presence: true, allow_nil: false, type: true


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

  def mailboxer_name
    self.username
  end

  def mailboxer_email(object)
    #self.email
    nil
  end

  def following?(followed)
    followings_bands.include?(followed) or followings_users.include?(followed)
  end


  def reviewed?(reviewed_id)
      Review.exists?(reviewer_id: self.id, reviewable_id: reviewed_id)
  end

  def actions_of_interest
     users_actions = UserAction.where( :sender_id => self.followings_users.map(&:id) ).where( :sender_type => "User")
     bands_actions = UserAction.where( :sender_id => self.followings_bands.map(&:id) ).where( :sender_type => "Band")
       bands_actions.or (users_actions)
  end

  def advertisments_of_interest
    near_bands = Band.where(nation: self.nation, region: self.region)
    Advertisment.where(:band_id => near_bands.map(&:id))
  end

  def activities_of_interest
    @from_followings = Activity.where(:band_id => self.followings_bands.map(&:id)).where(accessibility: "Public")
    @from_my_bands = Activity.where(:band_id => self.bands.map(&:id))
    @from_followings.or(@from_my_bands)
  end


  def is_waiting_for_join_response(band)

    !JoinRequest.where(band_id: band.id, sender_id: self.id, receiver_id: band.band_manager_id, pending: true).empty?
  end


  def has_just_sent_join_request(band)

    !JoinRequest.where(band_id: band.id, sender_id: self.id, receiver_id: band.band_manager_id, pending: false).empty?
  end

  def reviews_average

    return self.passive_reviews.average('rating').to_f

  end

  def send_welcome_notification
    Notification.create(
                     recipient: self,
                      actor: self,
                       action: ", Welcome to BandTogether, please complete your profile and enjoy our app!",
                       notifiable: self)
  end 

end
