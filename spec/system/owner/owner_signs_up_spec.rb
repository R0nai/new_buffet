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

  it 'And gets redirected to create buffet page ' do
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
    expect(page).to have_content "Cadastrar Buffet"
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
  end


end