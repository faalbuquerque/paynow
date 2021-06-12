class Company < ApplicationRecord
  has_one :billing_address
  has_many :workers

  validates :cnpj, presence: true
  validates :corporate_name, presence: true
  validates :billing_email, presence: true

  def create_token
    input = self.corporate_name + Time.current.to_s + rand.to_s
    company_hash = Digest::SHA256.hexdigest(input)[0..19]
    self.token = company_hash
  end

  def self.get_domain(params)
    params.split('@').last.split('.').first if not params.blank?
  end

  def persist_company(address)
    self.create_token
    self.save
    address.company_id = self.id
    address.save
  end
end
