class BilletMethod < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :tax_charge, presence: true
  validates :tax_max, presence: true
  validates :code_bank, presence: true
  validates :agency_bank, presence: true
  validates :account_number, presence: true
end
