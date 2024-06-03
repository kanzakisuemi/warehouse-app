require 'rails_helper'

describe 'usuário vê o estoque' do
  it 'na tela do galpão' do
    julia = User.create!(email: 'kanzaki@myself.com', name: 'Julia Kanzaki', password: 'password123')
    warehouse_los = Warehouse.create!(
      name: 'Los Angeles Airport',
      code: 'LOS',
      city: 'Los Angeles',
      area: 50_000,
      address: 'Avenida do Aeroporto, 500',
      cep: '98000-500',
      description: 'Galpão destinado à cargas importadas internacionalmente para Los Angeles'
    )
    kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )
    balm = ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)
    foundation = ProductModel.create!(name: 'power plush longwear foundation', weight: 80, width: 30, height: 60, depth: 10, sku: 'PWF-FIR-KYC001', supplier: kylie)
    blush = ProductModel.create!(name: 'powder blush sticks', weight: 55, width: 30, height: 70, depth: 10, sku: 'PBS-PNK-KYC011', supplier: kylie)
    order = Order.create!(warehouse: warehouse_los, supplier: kylie, user: julia, estimated_delivery_date: 11.days.from_now, status: :pending)
    3.times { StockProduct.create!(order: order, warehouse: warehouse_los, product_model: balm) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse_los, product_model: foundation) }

    login_as(julia)
    visit root_path
    click_on 'Los Angeles Airport'

    expect(page).to have_content('Itens em Estoque')
    expect(page).to have_content('3 x lip and cheek glow balm')
    expect(page).to have_content('2 x power plush longwear foundation')
    expect(page).not_to have_content('powder blush sticks')
  end
  it 'e dá baixa em um item' do
    julia = User.create!(email: 'kanzaki@myself.com', name: 'Julia Kanzaki', password: 'password123')
    warehouse_los = Warehouse.create!(
      name: 'Los Angeles Airport',
      code: 'LOS',
      city: 'Los Angeles',
      area: 50_000,
      address: 'Avenida do Aeroporto, 500',
      cep: '98000-500',
      description: 'Galpão destinado à cargas importadas internacionalmente para Los Angeles'
    )
    kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )
    balm = ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)
    order = Order.create!(warehouse: warehouse_los, supplier: kylie, user: julia, estimated_delivery_date: 11.days.from_now, status: :pending)
    3.times { StockProduct.create!(order: order, warehouse: warehouse_los, product_model: balm) }

    login_as(julia)
    visit root_path
    click_on 'Los Angeles Airport'

    select 'lip and cheek glow balm', from: 'Item para Saída'
    fill_in 'Destinatário', with: 'Carol Nagata'
    fill_in 'Endereço Destino', with: 'Rua Theodoro, 202 - Curitiba - Paraná'
    click_on 'Confirmar Retirada'

    expect(page).to have_content 'Item retirado com sucesso!'
    expect(page).to have_content('2 x lip and cheek glow balm')
  end
end
