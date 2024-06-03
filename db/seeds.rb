# Users
julia = User.create!(email: 'kanzaki@myself.com', name: 'Julia Kanzaki', password: 'password123')
pedro = User.create!(email: 'pedro@apostolos.com', name: 'Pedro Pedra', password: 'password123')
paulo = User.create!(email: 'paulo@apostolos.com', name: 'Paulo Saulo', password: 'password123')
# Suppliers
kylie = Supplier.create!(
  corporate_name: 'Kylie Cosmetics, LLC',
  brand_name: 'Kylie Cosmetics',
  employer_identification_number: '8895400053',
  address: 'Quinta avenida, 350',
  city: 'New York',
  cep: '10118011',
  email: 'customerservice@kyliecosmetic.com'
)
skims = Supplier.create!(
  corporate_name: 'Skims Body, Inc.',
  brand_name: 'Skims',
  employer_identification_number: '7944670092',
  address: 'South La Cienega Boulevard, 3113',
  city: 'Los Angeles',
  cep: '90005480',
  email: 'help@skims.com'
)
rhode = Supplier.create!(
  corporate_name: 'HRBeauty LLC, dba Rhode',
  brand_name: 'Rhode',
  employer_identification_number: '8602900067',
  address: 'Oitava avenida, 1000',
  city: 'Beverly Hills',
  cep: '64818090',
  email: 'hello@rhodeskin.com'
)
# Warehouses
warehouse_los = Warehouse.create(
  name: 'Los Angeles Airport',
  code: 'LOS',
  city: 'Los Angeles',
  area: 50_000,
  address: 'Avenida do Aeroporto, 500',
  cep: '98000-500',
  description: 'Galpão destinado à cargas importadas internacionalmente para Los Angeles'
)
warehouse_sdu = Warehouse.create(
  name: 'Rio',
  code: 'SDU',
  city: 'Rio de Janeiro',
  area: 60_000,
  address: 'Avenida do Aeroporto, 600',
  cep: '72000-400',
  description: 'Galpão destinado à cargas do Rio'
)
# Product Models
ProductModel.create!(name: 'power plush longwear foundation', weight: 80, width: 30, height: 60, depth: 10, sku: 'PWF-FIR-KYC001', supplier: kylie)
ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)
ProductModel.create!(name: 'brief bodysuit', weight: 30, width: 18, height: 45, depth: 2, sku: 'BBS-BLK-SKM006', supplier: skims)
ProductModel.create!(name: 'thong bodysuit', weight: 30, width: 18, height: 45, depth: 2, sku: 'TBS-BLK-SKM007', supplier: skims)
ProductModel.create!(name: 'lip case', weight: 50, width: 5, height: 11, depth: 3, sku: 'LPC-GRY-RHD009', supplier: rhode)
ProductModel.create!(name: 'pineapple refresh', weight: 40, width: 5, height: 15, depth: 10, sku: 'CLN-PRF-RHD023', supplier: rhode)
# Orders
Order.create!(warehouse: warehouse_los, supplier: kylie, user: julia, estimated_delivery_date: 11.days.from_now)
Order.create!(warehouse: warehouse_los, supplier: skims, user: julia, estimated_delivery_date: 20.days.from_now)
Order.create!(warehouse: warehouse_sdu, supplier: rhode, user: pedro, estimated_delivery_date: 4.days.from_now)
Order.create!(warehouse: warehouse_sdu, supplier: rhode, user: paulo, estimated_delivery_date: 7.days.from_now)
