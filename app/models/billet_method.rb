class BilletMethod < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :tax_charge, presence: true
  validates :tax_max, presence: true
  validates :code_bank, presence: true
  validates :agency_bank, presence: true
  validates :account_number, presence: true
  validate :check_if_already_in_company

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

  def check_if_already_in_company
    if self.company && self.company.billet_methods.exists?(name: self.name) && self.id.nil? 
      errors.add(:base, :invalid, message: I18n.t('payment_method_already'))
    end
  end
end
