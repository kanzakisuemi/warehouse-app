require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
      
      visit root_path
      click_on 'Rio'
      click_on 'Remover Galpão'
  
      expect(current_path).to eq root_path
      expect(page).to have_content('Galpão excluído com sucesso')
      expect(page).not_to have_content('Rio')
  end

  it 'e não apaga outros galpões' do
    warehouse_sdu = Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Aeroporto, 600', cep: '72000-400', description: 'Galpão destinado à cargas do Rio')
    warehouse_mcz = Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Avenida do Aeroporto, 500', cep: '98000-500', description: 'Galpão destinado à cargas de Maceio')

    visit root_path
    click_on 'Rio'
    click_on 'Remover Galpão'

    expect(current_path).to eq root_path
    expect(page).to have_content('Galpão excluído com sucesso')
    expect(page).not_to have_content('Rio')
    expect(page).to have_content('Maceio')
  end
end
