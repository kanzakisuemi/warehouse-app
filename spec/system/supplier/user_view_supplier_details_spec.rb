require 'rails_helper'

describe 'Usuário acessa um fornecedor' do
  it 'e vê detalhes' do
    Supplier.create!(corporate_name: 'Kylie Cosmetics, LLC', brand_name: 'Kylie Cosmetics', employer_identification_number: '8895400053', address: 'Quinta avenida, 350', city: 'New York', cep: '10118011', email: 'customerservice@kyliecosmetic.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'Kylie Cosmetics'

    expect(page).to have_content('Kylie Cosmetics, LLC')
    expect(page).to have_content('Kylie Cosmetics')
    expect(page).to have_content('8895400053')
    expect(page).to have_content('Quinta avenida, 350')
    expect(page).to have_content('New York')
    expect(page).to have_content('10118011')
    expect(page).to have_content('customerservice@kyliecosmetic.com')
  end

  it 'e volta para a tela inicial' do
    Supplier.create!(corporate_name: 'Kylie Cosmetics, LLC', brand_name: 'Kylie Cosmetics', employer_identification_number: '8895400053', address: 'Quinta avenida, 350', city: 'New York', cep: '10118011', email: 'customerservice@kyliecosmetic.com')

    visit root_path
    click_on 'Fornecedores'
    click_on 'Kylie Cosmetics'
    click_on 'Voltar'

    expect(current_path).to eq(suppliers_path)
  end
end
