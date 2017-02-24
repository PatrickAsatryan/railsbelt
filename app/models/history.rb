class History < ActiveRecord::Base
  belongs_to :lender
  belongs_to :borrower

  validates :amount, presence: true
end
