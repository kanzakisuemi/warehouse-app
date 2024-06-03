require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
  it 'com sucesso' do
    julia = User.create!(email: 'kanzaki@myself.com', name: 'Julia Kanzaki', password: 'password123')
    kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )
    warehouse_los = Warehouse.create(
      name: 'Los Angeles Airport',
      code: 'LOS',
      city: 'Los Angeles',
      area: 50_000,
      address: 'Avenida do Aeroporto, 500',
      cep: '98000-500',
      description: 'Galpão destinado à cargas importadas internacionalmente para Los Angeles'
    )
    order = Order.create!(warehouse: warehouse_los, supplier: kylie, user: julia, estimated_delivery_date: 11.days.from_now)
    foundation = ProductModel.create!(name: 'power plush longwear foundation', weight: 80, width: 30, height: 60, depth: 10, sku: 'PWF-FIR-KYC001', supplier: kylie)
    balm = ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)

    login_as(julia)
    visit root_path
    click_on 'Pedidos'
    click_on 'Kylie Cosmetics LOS'
    click_on 'Adicionar Item'

    select 'power plush longwear foundation', from: 'Produto'
    fill_in 'Quantidade', with: 1

    click_on 'Adicionar Item'

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso!'
    expect(page).to have_content 'power plush longwear foundation'
    expect(page).to have_content '1'
  end
  it 'e não vê itens de outro fornedor' do
    julia = User.create!(email: 'kanzaki@myself.com', name: 'Julia Kanzaki', password: 'password123')
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
    warehouse_los = Warehouse.create(
      name: 'Los Angeles Airport',
      code: 'LOS',
      city: 'Los Angeles',
      area: 50_000,
      address: 'Avenida do Aeroporto, 500',
      cep: '98000-500',
      description: 'Galpão destinado à cargas importadas internacionalmente para Los Angeles'
    )
    order = Order.create!(warehouse: warehouse_los, supplier: kylie, user: julia, estimated_delivery_date: 11.days.from_now)
    foundation = ProductModel.create!(name: 'power plush longwear foundation', weight: 80, width: 30, height: 60, depth: 10, sku: 'PWF-FIR-KYC001', supplier: kylie)
    balm = ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)
    bodysuit = ProductModel.create!(name: 'thong bodysuit', weight: 30, width: 18, height: 45, depth: 2, sku: 'TBS-BLK-SKM007', supplier: skims)

    login_as(julia)
    visit root_path
    click_on 'Pedidos'
    click_on 'Kylie Cosmetics LOS'
    click_on 'Adicionar Item'

    expect(page).to have_content 'power plush longwear foundation'
    expect(page).to have_content 'lip and cheek glow balm'
    expect(page).not_to have_content 'thong bodysuit'
  end
end
