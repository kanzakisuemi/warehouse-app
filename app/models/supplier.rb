class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :employer_identification_number, :address, :city, :cep, :email, presence: true
  validates :employer_identification_number, length: { is: 10 }
  validates :employer_identification_number, uniqueness: true
end
