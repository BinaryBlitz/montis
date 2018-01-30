class User < ApplicationRecord
  has_one :reviews, dependent: :destroy
  has_many :loans, dependent: :destroy

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :document, DocumentUploader
end
