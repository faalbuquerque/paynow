class PixMethod < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :tax_charge, presence: true
  validates :tax_max, presence: true
  validates :code_bank, presence: true
  validates :code_pix, presence: true
end
