class CardMethod < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :tax_charge, presence: true
  validates :tax_max, presence: true
  validates :code, presence: true
end
