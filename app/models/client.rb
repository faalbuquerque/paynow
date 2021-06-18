class Client < ApplicationRecord
  has_many :company_tokens

  def create_client_token
    input = self.cpf + Time.current.to_s + rand.to_s
    client_hash = Digest::SHA256.hexdigest(input)[0..19]
    self.token = client_hash
  end
end
