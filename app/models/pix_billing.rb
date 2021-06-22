class PixBilling < ApplicationRecord

  def create_token
    input = self.client_cpf + Time.current.to_s + rand.to_s
    pix_hash = Digest::SHA256.hexdigest(input)[0..19]
    self.token = pix_hash
  end
end
