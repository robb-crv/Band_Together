class UserAction < ApplicationRecord
  belongs_to :sender, polymorphic: true,  foreign_key: 'sender_id'
  belongs_to :receiver, polymorphic: true, foreign_key: 'receiver_id'




  def receiver_url
    case receiver

       when Band
         "/bands/#{receiver.id}"

       when User
         "/users/show?id=#{receiver.id}"

       when Activity
         "/activities/#{receiver.id}"
       when Advertisment
         "/advertisments/#{receiver.id}"
       else
         "/users/show?id=#{sender.id}"
      end
  end

  def sender_url
    case sender
    when Band
      "/bands/#{sender.id}"
    when User
      "/users/show?id=#{sender.id}"
      else
        "#"
    end
  end

  def sender_label
    case sender
      when Band
        "The band " << sender.name
      when User
        sender.username
      else
        ""
    end
  end


  class  ReceiverTypeValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      record.errors.add attribute, "Not a valid receiver type" unless ["Activity","Advertisment","User","Band", nil].include? value
    end
  end

  class  SenderTypeValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      record.errors.add attribute, "Not a valid receiver type" unless ["User","Band"].include? value
    end
  end

  def sender_exists
    case sender_type

     when "Band"

         errors.add(:sender_id, "It's not a valid band") unless !Band.find_by_id(sender_id).nil?
     when "User"

         errors.add(:sender_id, "It's not a valid user") unless !User.find_by_id(sender_id).nil?

     else

         nil
      end
  end


  def receiver_exists
    case receiver_type

     when "Band"

         errors.add(:receiver_id, "It's not a valid band") unless !Band.find_by_id(receiver_id).nil?
     when "User"

         errors.add(:receiver_id, "It's not a valid user") unless !User.find_by_id(receiver_id).nil?

     when "Activity"

         errors.add(:receiver_id, "It's not a valid activity") unless !Activity.find_by_id(receiver_id).nil?
     when "Advertisment"

         errors.add(:receiver_id, "It's not a valid advertisment") unless !Advertisment.find_by_id(receiver_id).nil?

     else

         nil
      end
  end

  #Validations
  validate :receiver_exists
  validate :sender_exists
  validates :action, presence: true, length: {maximum: 100}, allow_blank: false, allow_nil: false

  validates :sender_id, presence: true, allow_nil:false
  validates :sender_type, presence: true, allow_nil: false, sender_type: true
  validates :receiver_id, presence: false, allow_nil: true
  validates :receiver_type, presence: false , allow_nil: true, receiver_type: true

end
