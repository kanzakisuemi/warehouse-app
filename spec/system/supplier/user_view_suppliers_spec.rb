require 'rails_helper'

describe 'Usuário acessa página com lista de fornecedores' do
  it 'e vê fornecedores cadastrados' do
    Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )
    Supplier.create!(
      corporate_name: 'Skims Body, Inc.',
      brand_name: 'Skims',
      employer_identification_number: '7944670092',
      address: 'South La Cienega Boulevard, 3113',
      city: 'Los Angeles',
      cep: '90005480',
      email: 'help@skims.com'
    )

    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('Kylie Cosmetics')
    expect(page).to have_content('Skims')
  end

  it 'e não existem fornecedores cadastrados' do
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content('Não existem fornecedores cadastrados')
  end
end
