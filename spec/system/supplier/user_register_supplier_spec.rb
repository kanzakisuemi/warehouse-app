require 'rails_helper'

describe 'Usuário cadastra fornecedor' do
  it 'a partir da tela inicial com sucesso' do

    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    expect(page).to have_content('Nome Corporativo')
    expect(page).to have_content('Nome da Marca')
    expect(page).to have_content('CNPJ')
    expect(page).to have_content('Endereço')
    expect(page).to have_content('Cidade')
    expect(page).to have_content('CEP')
    expect(page).to have_content('Email')

    fill_in 'Nome Corporativo', with: 'Kylie Cosmetics, LLC'
    fill_in 'Nome da Marca', with: 'Kylie Cosmetics'
    fill_in 'CNPJ', with: '8895400053'
    fill_in 'Endereço', with: 'Quinta avenida, 350'
    fill_in 'Cidade', with: 'New York'
    fill_in 'CEP', with: '10118011'
    fill_in 'Email', with: 'customerservice@kyliecosmetic.com'

    click_on 'Criar Fornecedor'

    expect(current_path).to eq(suppliers_path)
    expect(page).to have_content('Fornecedor cadastrado com sucesso')

    expect(page).to have_content('Kylie Cosmetics')
    expect(page).to have_content('New York')
  end

  it 'com dados incompletos' do  

    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    fill_in 'Nome Corporativo', with: ''
    fill_in 'Nome da Marca', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Email', with: ''

    click_on 'Criar Fornecedor'

    expect(page).to have_content('Fornecedor não cadastrado')
    expect(page).to have_content('Nome Corporativo não pode ficar em branco')
    expect(page).to have_content('Nome da Marca não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Email não pode ficar em branco')
  end

  it 'com CNPJ já cadastrado' do
    Supplier.create!(
      corporate_name: 'Khy by Kylie Jenner', 
      brand_name: 'Khy', 
      employer_identification_number: '8895400053', 
      address: 'Quinta avenida, 350', 
      city: 'New York', 
      cep: '10118011', 
      email: 'support@khy.com'
    )

    visit root_path
    click_on 'Fornecedores'
    click_on 'Cadastrar Fornecedor'

    fill_in 'Nome Corporativo', with: 'Kylie Cosmetics, LLC'
    fill_in 'Nome da Marca', with: 'Kylie Cosmetics'
    fill_in 'CNPJ', with: '8895400053'
    fill_in 'Endereço', with: 'Quinta avenida, 350'
    fill_in 'Cidade', with: 'New York'
    fill_in 'CEP', with: '10118011'
    fill_in 'Email', with: 'customerservice@kyliecosmetic.com'

    click_on 'Criar Fornecedor'

    expect(page).to have_content('Fornecedor não cadastrado')
  end
end
