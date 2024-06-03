class ProductModel < ApplicationRecord
  belongs_to :supplier, class_name: 'Supplier', foreign_key: 'supplier_id'
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, :sku, presence: true
end
