require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
    Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'Kylie Cosmetics'
    click_on 'Editar Fornecedor'

    expect(page).to have_field('Nome Corporativo', with: 'Kylie Cosmetics, LLC')
    expect(page).to have_field('Nome da Marca', with: 'Kylie Cosmetics')
    expect(page).to have_field('CNPJ', with: '8895400053')
    expect(page).to have_field('Endereço', with: 'Quinta avenida, 350')
    expect(page).to have_field('Cidade', with: 'New York')
    expect(page).to have_field('CEP', with: '10118011')
    expect(page).to have_field('Email', with: 'customerservice@kyliecosmetic.com')
  end

  it 'com sucesso' do
    k = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'Kylie Cosmetics'
    click_on 'Editar Fornecedor'

    fill_in 'Nome Corporativo', with: 'Kylie Cosmetics, Inc.'
    fill_in 'Nome da Marca', with: 'Kylie Cosmetics'
    fill_in 'CNPJ', with: '8895400053'
    fill_in 'Endereço', with: 'Quinta avenida, 350'
    fill_in 'Cidade', with: 'New York'
    fill_in 'CEP', with: '10118011'
    fill_in 'Email', with: 'stormy@kyliecosmetic.com'
    click_on 'Atualizar Fornecedor'

    expect(current_path).to eq supplier_path(k)
    expect(page).to have_content('Fornecedor atualizado com sucesso')
    expect(page).to have_content('Kylie Cosmetics, Inc.')
    expect(page).to have_content('Kylie Cosmetics')
    expect(page).to have_content('8895400053')
    expect(page).to have_content('Quinta avenida, 350')
    expect(page).to have_content('New York')
    expect(page).to have_content('10118011')
    expect(page).to have_content('stormy@kyliecosmetic.com')
  end

  it 'e mantém os campos obrigatórios' do
    Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'stormy@kyliecosmetic.com'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'Kylie Cosmetics'
    click_on 'Editar Fornecedor'

    fill_in 'Nome Corporativo', with: ''
    fill_in 'Nome da Marca', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Email', with: ''
    click_on 'Atualizar Fornecedor'

    expect(page).to have_content('Nome Corporativo não pode ficar em branco')
    expect(page).to have_content('Nome da Marca não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end
end
