require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar StockProduct' do
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
      balm = ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: supplier_kylie)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: balm)

      expect(stock_product.serial_number.length).to eq 20
    end
    it 'e não pode ser modificado' do
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      user_kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')
      order = Order.create!(supplier: kylie, warehouse: warehouse, estimated_delivery_date: 1.month.from_now, user: user_kendall)
      balm = ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)
      foundation = ProductModel.create!(name: 'power plush longwear foundation', weight: 80, width: 30, height: 60, depth: 10, sku: 'PWF-FIR-KYC001', supplier: kylie)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: balm)
      original_serial_number = stock_product.serial_number
      stock_product.update!(product_model: foundation)

      expect(stock_product.serial_number).to eq original_serial_number
    end
  end
  describe '#available?' do
    it 'true se não tiver destino' do
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      user_kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')
      order = Order.create!(supplier: kylie, warehouse: warehouse, estimated_delivery_date: 1.month.from_now, user: user_kendall)
      balm = ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: balm)

      expect(stock_product.available?).to eq true
    end
    it 'false se não tiver destino' do
      warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      kylie = Supplier.create!(
        corporate_name: 'Kylie Cosmetics, LLC',
        brand_name: 'Kylie Cosmetics',
        employer_identification_number: '8895400053',
        address: 'Quinta avenida, 350',
        city: 'New York',
        cep: '10118011',
        email: 'customerservice@kyliecosmetic.com'
      )
      user_kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')
      order = Order.create!(supplier: kylie, warehouse: warehouse, estimated_delivery_date: 1.month.from_now, user: user_kendall)
      balm = ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)

      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: balm)
      stock_product.create_stock_product_destination!(recipient: 'Julia Kanzaki', address: 'Av Madre Leonia Milito, 1300')

      expect(stock_product.available?).to eq false
    end
  end
end
