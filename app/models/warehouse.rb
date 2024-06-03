class Warehouse < ApplicationRecord
  has_many :stock_products
  validates :name, :code, :city, :area, :address, :cep, :description, presence: true
  validates :code, length: { is: 3 }
  validates :code, uniqueness: true

  def code_and_name
    "#{code} - #{name}"
  end
end
