class Worker < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company

  validate :check_email

  enum status: { released: 0, block: 1 }

  private

  def check_email
    domains = [ "gmail", "hotmail", "yahoo" ]
    if self.email.present?
      domains.each do |domain|
        if self.email.split('@').last.split('.').first.eql?(domain)
          errors.add(:email, "não é válido")
        end
      end
    end
  end
end
