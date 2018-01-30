class Loan < ApplicationRecord
  belongs_to :user

  before_validation :create_user

  validates :amount, :term, :first_name, :phone_number, presence: true
  validates :amount, :term, numericality: { greater_than: 0 }
  validates :term, numericality: { less_than_or_equal_to: 12 }

  def full_name
    "#{last_name} #{first_name} #{patronymic_name}"
  end

  private

  def create_user
    generated_password = Devise.friendly_token.first(8)
    user = User.find_or_create_by!(email: email) { |user| user.password = generated_password }
    self.user = user
    UserMailer.new_user(user, generated_password).deliver_later
  end
end
