class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:phone_number]

  mount_uploader :document, DocumentUploader

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
