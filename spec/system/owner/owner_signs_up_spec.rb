require 'rails_helper'

describe 'Owner signs up' do
  it 'successfully' do
    # Arrange

    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'abc@de.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    fill_in 'Nome', with: 'Testman'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'abc@de.com'
    expect(page).to have_content 'Sair'
    owner = Owner.last
    expect(owner.name).to eq 'Testman'
  end
end