require 'rails_helper'

describe 'Usuário' do
  it 'não cadastra pois deve estar autenticado' do
    visit root_path
    click_on 'Pedidos'

    expect(current_path).to eq(new_user_session_path)
  end

  it 'cadastra pedido com sucesso' do
    #Arrange
    user_kendall = User.create!(email: 'kendall@jenner.com', password: 'password123', name: 'Kendall Jenner')
    warehouse_mcz = Warehouse.create(
      name: 'Maceio',
      code: 'MCZ',
      city: 'Maceio',
      area: 50_000,
      address: 'Avenida do Aeroporto, 500',
      cep: '98000-500',
      description: 'Galpão destinado à cargas de Maceio'
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
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')
    #Act
    login_as(user_kendall)
    visit root_path
    click_on 'Pedidos'
    expect(current_path).to eq(orders_path)
    click_on 'Cadastrar Pedido'
    select supplier_kylie.brand_name, from: 'Fornecedor'
    select warehouse_sdu.code_and_name, from: 'Galpão'
    fill_in 'Data Prevista', with: '10/01/2026'
    click_on 'Criar Pedido'
    #Assert
    expect(page).to have_content('Pedido cadastrado com sucesso')
    expect(page).to have_content('Pedido ABC12345')
    expect(page).to have_content('Kylie Cosmetics')
    expect(page).to have_content('SDU - Rio')
    expect(page).to have_content('Kendall Jenner - kendall@jenner.com')
    expect(page).to have_content('10/01/2026')
    expect(page).to have_content('Pendente')    
    expect(page).not_to have_content('Maceio')
    expect(page).not_to have_content('Skims')
  end
  it 'não cadastra pedido pois não informa a data de entrega' do
    #Arrange
    user_kendall = User.create!(email: 'kendall@jenner.com', password: 'password123', name: 'Kendall Jenner')
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
    # Act
    login_as(user_kendall)
    visit root_path
    click_on 'Pedidos'
    click_on 'Cadastrar Pedido'
    select supplier_kylie.brand_name, from: 'Fornecedor'
    select warehouse_mcz.code_and_name, from: 'Galpão'
    fill_in 'Data Prevista', with: ''
    click_on 'Criar Pedido'
    # Assert
    expect(page).to have_content('Data Prevista não pode ficar em branco')
  end
end
