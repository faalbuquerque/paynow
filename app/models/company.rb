class Company < ApplicationRecord
  has_one :billing_address
  has_many :workers

  validates :cnpj, presence: true
  validates :corporate_name, presence: true
  validates :billing_email, presence: true

  def self.create_token
    'jghmhgfhjgy5678iuhggj0gu'
  end

  def self.get_domain(params)
    params.split('@').last.split('.').first if not params.blank?
  end

  def persist_company(address)
    self.save
    address.company_id = self.id
    address.save
  end
end

