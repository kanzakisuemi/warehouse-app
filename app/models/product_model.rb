class ProductModel < ApplicationRecord
  belongs_to :supplier, class_name: 'Supplier', foreign_key: 'supplier_id'
  validates :name, :sku, presence: true
end
