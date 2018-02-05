class User < ApplicationRecord
  has_one :review, dependent: :destroy
  has_many :loans, dependent: :destroy
  has_many :payments, through: :loans

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :document, DocumentUploader
end
