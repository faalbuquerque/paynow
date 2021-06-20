class PixMethod < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :tax_charge, presence: true
  validates :tax_max, presence: true
  validates :code_bank, presence: true
  validates :code_pix, presence: true

  def self.available_methods
    company = Company.find_by(corporate_name: 'Paynow')
    company.pix_methods.where(available: true)
  end

  def self.clone_template(pix_params, pix_id)
    company = Company.find_by(corporate_name: 'Paynow')

    payment_method = company.pix_methods.find(pix_id).dup
    payment_method.update(pix_params)
    payment_method
  end
end
