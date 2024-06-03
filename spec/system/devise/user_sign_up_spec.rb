require 'rails_helper'

describe 'Usuário cria conta' do
  it 'com sucesso' do
    visit root_path

    click_on 'Entrar'
    click_on 'Criar Conta'

    within('form#new_user') do
      fill_in 'Nome', with: 'Kylie Kristen Jenner'
      fill_in 'E-mail', with: 'khy@jenner.com'
      fill_in 'Senha', with: 'password123'
      fill_in 'Confirme sua senha', with: 'password123'
      click_on 'Criar Conta'
    end

      expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
      expect(page).to have_content('khy@jenner.com')
      expect(page).to have_button('Sair')
      ky = User.last
      expect(ky.name).to eq('Kylie Kristen Jenner')
  end
end
