require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    user_kendall = User.create!(email: 'kendall@jenner.com', password: 'password123', name: 'Kendall Jenner')
    login_as(user_kendall)
    visit root_path

    within('nav') do
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end
  it 'e deve estar autenticado' do
    visit root_path

    within('nav') do
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end
  it 'e encontra um pedido' do
    user_kendall = User.create!(email: 'kendall@jenner.com', password: 'password123', name: 'Kendall Jenner')
    warehouse_sdu = Warehouse.create(
      name: 'Rio',
      code: 'SDU',
      city: 'Rio de Janeiro',
      area: 60_000,
      address: 'Avenida do Aeroporto, 600',
      cep: '72000-400',
      description: 'Galpão destinado à cargas do Rio'
    )
    supplier_kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )
    order = Order.create!(user: user_kendall, warehouse: warehouse_sdu, supplier: supplier_kylie, estimated_delivery_date: 2.days.from_now)

    login_as(user_kendall)
    visit root_path

    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content("Resultados da busca por: #{ order.code }")
    expect(page).to have_content('1 pedido encontrado')
    expect(page).to have_content(order.code)
    expect(page).to have_content(warehouse_sdu.code_and_name)
    expect(page).to have_content(supplier_kylie.brand_name)
  end
  it 'e encontra multiplos pedidos' do
    user_kendall = User.create!(email: 'kendall@jenner.com', password: 'password123', name: 'Kendall Jenner')
    warehouse_sdu = Warehouse.create(
      name: 'Rio',
      code: 'SDU',
      city: 'Rio de Janeiro',
      area: 60_000,
      address: 'Avenida do Aeroporto, 600',
      cep: '72000-400',
      description: 'Galpão destinado à cargas do Rio'
    )
    warehouse_mcz = Warehouse.create(
      name: 'Maceio',
      code: 'MCZ',
      city: 'Maceio',
      area: 50_000,
      address: 'Avenida do Aeroporto, 500',
      cep: '98000-500',
      description: 'Galpão destinado à cargas de Maceio'
    )
    supplier_kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )
    supplier_skims = Supplier.create!(
      corporate_name: 'Skims Body, Inc.',
      brand_name: 'Skims',
      employer_identification_number: '7944670092',
      address: 'South La Cienega Boulevard, 3113',
      city: 'Los Angeles',
      cep: '90005480',
      email: 'help@skims.com'
    )
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00001')
    order_1 = Order.create!(user: user_kendall, warehouse: warehouse_sdu, supplier: supplier_kylie, estimated_delivery_date: 2.days.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('MCZ12345')
    order_2 = Order.create!(user: user_kendall, warehouse: warehouse_mcz, supplier: supplier_kylie, estimated_delivery_date: 4.days.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00002')
    order_3 = Order.create!(user: user_kendall, warehouse: warehouse_sdu, supplier: supplier_skims, estimated_delivery_date: 3.days.from_now)

    login_as(user_kendall)
    visit root_path

    fill_in 'Buscar Pedido', with: 'SDU'
    click_on 'Buscar'

    expect(page).to have_content('2 pedidos encontrados')
    expect(page).to have_content('SDU00001')
    expect(page).to have_content('SDU00002')
    expect(page).not_to have_content('MCZ12345')
  end
end
