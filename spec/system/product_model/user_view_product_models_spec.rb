require 'rails_helper'

describe 'Usuário vê modelos de podutos' do
  it 'se estiver autenticado' do
    visit root_path
    within('nav') do
      click_on "Produtos"
    end

    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    visit root_path
    within('nav') do
      click_on 'Produtos'
    end
  end

  it 'com sucesso' do
    kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')

    visit root_path
    login(kendall)

    kylie = Supplier.create!(
      corporate_name: 'Kylie Cosmetics, LLC',
      brand_name: 'Kylie Cosmetics',
      employer_identification_number: '8895400053',
      address: 'Quinta avenida, 350',
      city: 'New York',
      cep: '10118011',
      email: 'customerservice@kyliecosmetic.com'
    )
    ProductModel.create!(name: 'power plush longwear foundation', weight: 80, width: 30, height: 60, depth: 10, sku: 'PWF-FIR-KYC001', supplier: kylie)
    ProductModel.create!(name: 'lip and cheek glow balm', weight: 50, width: 60, height: 10, depth: 40, sku: 'LCB-PNK-KYC009', supplier: kylie)

    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(page).to have_content 'power plush longwear foundation'
    expect(page).to have_content 'lip and cheek glow balm'
  end

  it 'e não existem produtos cadastrados' do
    kendall = User.create!(email: 'kendall@jenner.com', password: 'pass123456', name: 'Kendall Jenner')
    login_as(kendall)

    visit root_path
    within('nav') do
      click_on 'Produtos'
    end

    expect(page).to have_content 'Não existem produtos cadastrados'
  end
end
