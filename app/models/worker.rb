class Worker < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company

  validate :check_email

  private

  def check_email
    domains = [ "gmail", "hotmail", "yahoo" ]

    domains.each do |domain|
      if email.split('@').last.split('.').first.eql?(domain)
        errors.add(:email, "não é válido")
      end
    end
  end
end
