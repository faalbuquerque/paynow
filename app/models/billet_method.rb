class BilletMethod < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :tax_charge, presence: true
  validates :tax_max, presence: true
  validates :code_bank, presence: true
  validates :agency_bank, presence: true
  validates :account_number, presence: true

  def self.available_methods
    company = Company.find_by(corporate_name: 'Paynow')
    company.billet_methods.where(available: true)
  end

  def self.clone_template(billet_params, billet_id)
    company = Company.find_by(corporate_name: 'Paynow')

    payment_method = company.billet_methods.find(billet_id).dup
    payment_method.update(billet_params)
    payment_method
  end
end
