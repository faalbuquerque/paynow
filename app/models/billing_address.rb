class BillingAddress < ApplicationRecord
  belongs_to :company

  def has_all_attributes?
    hash = {
      zip_code: self.zip_code,
      state: self.state,
      city: self.city,
      street: self.street,
      house_number: self.house_number,
      country: self.country
    }

    unless !hash.values.include?('') && !hash.values.include?(nil)
      hash.select { |key, value| value == '' || value == nil }.each do |item|
        self.errors.add(item[0], :blank)
      end
      return false
    end
    return true
  end
end
