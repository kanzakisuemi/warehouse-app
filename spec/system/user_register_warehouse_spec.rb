require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do

    visit root_path
    click_on 'Cadastrar Galpão'

    expect(page).to have_content('Nome')
    expect(page).to have_content('Descrição')
    expect(page).to have_content('Código')
    expect(page).to have_content('Endereço')
    expect(page).to have_content('Cidade')
    expect(page).to have_content('CEP')
    expect(page).to have_content('Área')
  end

  it 'com sucesso' do

    visit root_path
    click_on 'Cadastrar Galpão'

    fill_in 'Nome', with: 'Curitiba'
    fill_in 'Descrição', with: 'Galpão destinado à cargas internacionais'
    fill_in 'Código', with: 'CWB'
    fill_in 'Endereço', with: 'Avenida do Aeroporto, 1000'
    fill_in 'Cidade', with: 'Curitiba'
    fill_in 'CEP', with: '86050-270'
    fill_in 'Área', with: '100000'

    click_on 'Cadastrar'

    expect(current_path).to eq(root_path)

    expect(page).to have_content('Galpão cadastrado com sucesso')

    expect(page).to have_content('Curitiba')
    expect(page).to have_content('Código: CWB')
    expect(page).to have_content('Cidade: Curitiba')
    expect(page).to have_content('100000 m2')
    
  end
end
