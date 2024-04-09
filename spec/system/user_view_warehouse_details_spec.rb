require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do
  it 'e vê informações adicionais' do
    w = Warehouse.create(name: 'Curitiba', code: 'CWB', city: 'Curitiba', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '86050-270', description: 'Galpão destinado à cargas internacionais')

    visit(root_path)
    click_on('Curitiba')

    expect(page).to have_content('Galpão CWB')
    expect(page).to have_content('Nome: Curitiba')
    expect(page).to have_content('Cidade: Curitiba')
    expect(page).to have_content('Área: 100000 m2')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 86050-270')
    expect(page).to have_content('Galpão destinado à cargas internacionais')
  end

  it 'e volta para a tela inicial' do
    w = Warehouse.create(name: 'Curitiba', code: 'CWB', city: 'Curitiba', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '86050-270', description: 'Galpão destinado à cargas internacionais')

    visit(root_path)
    click_on('Curitiba')
    click_on('Voltar')

    expect(current_path).to eq(root_path)
  end
end
