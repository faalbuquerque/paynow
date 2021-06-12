class Admin < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def correct_password?(password)
    password_equivalent = BCrypt::Password.new(self.encrypted_password)
    plain_password = password

    password_equivalent == plain_password
  end
end
