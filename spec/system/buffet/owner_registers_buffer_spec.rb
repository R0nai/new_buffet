require 'rails_helper'

describe 'Owner registers a buffet' do
  it 'Owner clicks on register buffet and sees registration form' do
    # Arrange
    Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'abc@de.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Cadastrar um Buffet'

    # Assert
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

  it 'Successfully' do
      # Arrange
      owner = Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')

      # Act
      visit root_path
      click_on 'Entrar'
      within('form') do
        fill_in 'E-mail', with: 'abc@de.com'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
      end
      click_on 'Cadastrar um Buffet'
      fill_in 'Nome Fantasia', with: 'Kratos Buffet'
      fill_in 'Razão Social', with: 'Kratos Buffet Ltda.'
      fill_in 'CNPJ', with: '123456'
      fill_in 'Telefone', with: '12-99999999'
      fill_in 'E-mail', with: 'kratos@uol.com'
      fill_in 'Endereço', with: 'Rua do Kratos, 100'
      fill_in 'Bairro', with: 'Jardim Kratolândia'
      fill_in 'Cidade', with: 'Kratosland'
      fill_in 'Estado', with: 'SP'
      fill_in 'CEP', with: '12000-100'
      fill_in 'Descrição', with: 'Pequena descrição'
      click_on 'Cadastrar Buffet'
        
      # Assert
      buffet = Buffet.last
      expect(current_path).to eq root_path
      expect(buffet.owner_id).to eq owner.id
  end
end