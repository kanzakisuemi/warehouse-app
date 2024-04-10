require 'rails_helper'

describe 'Usuário cadastra um modelo de produto' do
  it 'com sucesso' do
    kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
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

    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar Produto'

    fill_in 'Nome', with: 'power plush longwear foundation'
    fill_in 'Peso', with: '80'
    fill_in 'Largura', with: '30'
    fill_in 'Altura', with: '60'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'PWF-FIR-KYC001'
    select 'Kylie Cosmetics', from: 'Fornecedor'
    click_on 'Criar Produto'

    expect(page).to have_content('Produto cadastrado com sucesso')
    expect(page).to have_content('power plush longwear foundation')
    expect(page).to have_content('80')
    expect(page).to have_content('30')
    expect(page).to have_content('60')
    expect(page).to have_content('10')
    expect(page).to have_content('PWF-FIR-KYC001')
    expect(page).to have_content('Kylie Cosmetics')
  end

  it 'deve preencher todos os campos' do
    kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )

    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar Produto'

    click_on 'Criar Produto'

    expect(page).to have_content('Não foi possível cadastrar o produto')
  end
end
