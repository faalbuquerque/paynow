class Product < ApplicationRecord
  belongs_to :company
  has_many :discounts

  validates :product_name, presence: true
  validates :product_price, presence: true

  def create_token
    input = self.product_name + Time.current.to_s + rand.to_s
    product_hash = Digest::SHA256.hexdigest(input)[0..19]
    self.token = product_hash
  end
end
