class Discount < ApplicationRecord
  belongs_to :product

  validates :amount, presence: true
  validates :payment_type, presence: true
end
