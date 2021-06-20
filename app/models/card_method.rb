class CardMethod < ApplicationRecord
  belongs_to :company

  validates :name, presence: true
  validates :tax_charge, presence: true
  validates :tax_max, presence: true
  validates :code, presence: true

  def self.available_methods
    company = Company.find_by(corporate_name: 'Paynow')
    company.card_methods.where(available: true)
  end

  def self.clone_template(card_params, card_id)
    company = Company.find_by(corporate_name: 'Paynow')

    payment_method = company.card_methods.find(card_id).dup
    payment_method.update(card_params)
    payment_method
  end
end
