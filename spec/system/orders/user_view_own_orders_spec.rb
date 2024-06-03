require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e não vê outros pedidos' do
    julia = User.create!(email: 'kanzaki@myself.com', name: 'Julia Kanzaki', password: 'password123')
    pedro = User.create!(email: 'pedro@apostolos.com', name: 'Pedro Pedra', password: 'password123')
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
    Order.create!(warehouse: warehouse_los, supplier: kylie, user: julia, estimated_delivery_date: 11.days.from_now)
    Order.create!(warehouse: warehouse_los, supplier: skims, user: julia, estimated_delivery_date: 20.days.from_now)
    Order.create!(warehouse: warehouse_sdu, supplier: skims, user: pedro, estimated_delivery_date: 4.days.from_now)

    login_as(julia)
    visit root_path
    within('nav') do
      click_on 'Pedidos'
    end

    click_on 'Ver meus Pedidos'

    expect(page).to have_link 'Kylie Cosmetics LOS'
    expect(page).to have_link 'Skims LOS'
    expect(page).not_to have_content 'Skims SDU'
  end
  it 'e visita um pedido' do
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
    skims = Supplier.create!(
      corporate_name: 'Skims Body, Inc.',
      brand_name: 'Skims',
      employer_identification_number: '7944670092',
      address: 'South La Cienega Boulevard, 3113',
      city: 'Los Angeles',
      cep: '90005480',
      email: 'help@skims.com'
    )
    Order.create!(warehouse: warehouse_los, supplier: kylie, user: julia, estimated_delivery_date: 11.days.from_now, status: 0)
    Order.create!(warehouse: warehouse_los, supplier: skims, user: julia, estimated_delivery_date: 20.days.from_now, status: 0)

    login_as(julia)
    visit root_path
    within('nav') do
      click_on 'Pedidos'
    end

    click_on 'Ver meus Pedidos'

    expect(page).to have_link 'Kylie Cosmetics LOS'
    expect(page).to have_link 'Skims LOS'
    
    click_on 'Kylie Cosmetics LOS'
    expect(page).to have_content kylie.brand_name
    expect(page).to have_content warehouse_los.code_and_name
    expect(page).to have_content julia.name_and_email
    expect(page).to have_content I18n.localize(11.days.from_now.to_date)
    expect(page).to have_content 'Pendente'
  end
  it 'e vê itens do pedido' do
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

    OrderItem.create!(order: order, product_model: foundation, quantity: 1)
    OrderItem.create!(order: order, product_model: balm, quantity: 3)

    login_as(julia)
    visit root_path
    click_on 'Pedidos'
    click_on 'Ver meus Pedidos'
    click_on 'Kylie Cosmetics LOS'

    expect(page).to have_content 'power plush longwear foundation'
    expect(page).to have_content '1'
    expect(page).to have_content 'lip and cheek glow balm'
    expect(page).to have_content '3'
  end
end
