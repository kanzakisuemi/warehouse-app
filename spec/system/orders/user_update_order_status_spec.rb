require 'rails_helper'

describe 'Usuário altera status do pedido' do
  it 'para entregue' do
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
    OrderItem.create!(order: order, product_model: balm, quantity: 5)

    login_as(julia)
    visit root_path
    click_on 'Pedidos'
    click_on 'Ver meus Pedidos'
    click_on 'Kylie Cosmetics LOS'

    click_on 'Entregue'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content('Entregue')
    expect(page).not_to have_button('Cancelar')
    expect(page).not_to have_button('Entregue')
    expect(StockProduct.count).to eq 5
    estoque = StockProduct.where(product_model: balm, warehouse: warehouse_los).count
    expect(estoque).to eq 5
  end
  it 'para cancelado' do
    julia = User.create!(email: 'kanzaki@myself.com', name: 'Julia Kanzaki', password: 'password123')
    warehouse_los = Warehouse.create(
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
    OrderItem.create!(order: order, product_model: balm, quantity: 5)

    login_as(julia)
    visit root_path
    click_on 'Pedidos'
    click_on 'Ver meus Pedidos'
    click_on 'Kylie Cosmetics LOS'

    click_on 'Cancelar'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content('Cancelado')
    expect(page).not_to have_button('Em andamento')
    expect(page).not_to have_button('Entregue')
    expect(page).not_to have_button('Cancelar')
    expect(StockProduct.count).to eq 0
  end
end
