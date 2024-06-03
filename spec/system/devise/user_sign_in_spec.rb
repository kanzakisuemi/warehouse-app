require 'rails_helper'

describe 'Usuário' do
  it 'chega até a página de login' do
    visit root_path

    click_on 'Entrar'

    expect(current_path).to eq(new_user_session_path)
  end

  it 'faz login com sucesso' do
    User.create!(email: 'juu@kanzaki.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    within('form#new_user') do
      fill_in 'E-mail', with: 'juu@kanzaki.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    within('nav') do
      expect(page).to have_button('Sair')
      expect(page).not_to have_link('Entrar')
      expect(page).to have_content('juu@kanzaki.com')
    end
  end

  it 'faz logout com sucesso' do
    User.create!(email: 'juu@kanzaki.com', password: '123456')

    visit root_path
    click_on 'Entrar'

    within('form#new_user') do
      fill_in 'E-mail', with: 'juu@kanzaki.com'
      fill_in 'Senha', with: '123456'
      click_on 'Entrar'
    end

    click_on 'Sair'

    expect(page).to have_content('Logout efetuado com sucesso.')
    expect(page).to have_link('Entrar')
    expect(page).not_to have_button('Sair')
    expect(page).not_to have_content('juu@kanzaki.com')
  end
end
