require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
          
    visit root_path
    click_on 'Rio'
    click_on 'Editar Galpão'

    expect(page).to have_field('Nome', with: 'Rio')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('Área', with: '60000')
    expect(page).to have_field('Endereço', with: 'Avenida do Aeroporto, 600')
    expect(page).to have_field('CEP', with: '72000-400')
    expect(page).to have_field('Descrição', with: 'Galpão destinado à cargas do Rio')
  end

  it 'com sucesso' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
          
    visit root_path
    click_on 'Rio'
    click_on 'Editar Galpão'
    fill_in 'Nome', with: 'São Paulo'
    fill_in 'Código', with: 'CGH'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Área', with: '70000'
    fill_in 'Endereço', with: 'Avenida do Aeroporto, 700'
    fill_in 'CEP', with: '72000-500'
    fill_in 'Descrição', with: 'Galpão destinado à cargas de São Paulo'
    click_on 'Atualizar Galpão'

    expect(current_path).to eq root_path
    expect(page).to have_content('Galpão atualizado com sucesso')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('CGH')
    expect(page).to have_content('São Paulo')
    expect(page).to have_content('70000')
  end

  it 'e mantém os campos obrigatórios' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
          
    visit root_path
    click_on 'Rio'
    click_on 'Editar Galpão'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Atualizar Galpão'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Código não pode ficar em branco')
    expect(page).to have_content('Cidade não pode ficar em branco')
    expect(page).to have_content('Área não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('CEP não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
  end
end
