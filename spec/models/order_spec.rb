require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    it 'e deve ter um código' do
      warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      supplier_kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      user_kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')
      order = Order.new(supplier: supplier_kylie, warehouse: warehouse, estimated_delivery_date: '2025-01-01', user: user_kendall)

      result = order.valid?

      expect(result).to be true
    end
    it 'e data estimada de entrega deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: '')

      order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      expect(result).to be true
    end
    it 'e data estimada de entrega deve ser após a data do pedido' do
      order = Order.new(estimated_delivery_date: 1.day.from_now)

      order.valid?

      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end
  end
  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      supplier_kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      user_kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')
      order = Order.new(supplier: supplier_kylie, warehouse: warehouse, estimated_delivery_date: '2026-01-01', user: user_kendall)

      order.save!
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq(8)
    end
    it 'e o código é único' do
      warehouse = Warehouse.new(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      supplier_kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      user_kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')
      first_order = Order.create!(supplier: supplier_kylie, warehouse: warehouse, estimated_delivery_date: '2026-01-01', user: user_kendall)
      second_order = Order.new(supplier: supplier_kylie, warehouse: warehouse, estimated_delivery_date: '2026-02-01', user: user_kendall)

      second_order.save!
      result = second_order.code

      expect(result).not_to be eq(first_order.code)
    end
    it 'e não deve der modificado' do
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      supplier_kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      user_kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')
      order = Order.create!(supplier: supplier_kylie, warehouse: warehouse, estimated_delivery_date: 1.month.from_now, user: user_kendall)

      original_code = order.code
      order.update!(estimated_delivery_date: 25.days.from_now)

      expect(order.code).to eq(original_code)
    end
  end
end
