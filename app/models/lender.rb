class Lender < ActiveRecord::Base
  has_secure_password

  has_many :histories
  has_many :borrowers, through: :histories

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :first_name, :last_name, :email, :password, :money, presence: true

  validate :borroweremail

  def borroweremail
    if Borrower.where(:email => self.email).any?
      errors.add(:email, 'already exists')
    end
  end
end
