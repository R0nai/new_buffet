require 'rails_helper'

describe 'Owner signs-in' do

  it 'and gets redirected to new_buffet_path in order to create a buffet' do
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

    # Assert
    expect(current_path).to eq new_buffet_path

  end

  it 'Sucessfully' do
    # Arrange
    owner = Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')
    buffet = Buffet.create!(brand: 'Kratos Buffet',
                   corporate_name: 'Kratos Buffet Ltda.',
                   registration_number: '123456',
                   phone_number: '12-99999999',
                   email: 'kratos@uol.com',
                   address: 'Rua do Kratos, 100',
                   district: 'Jardim Kratolândia',
                   city: 'Kratoland',
                   state: 'SP',
                   zip_code: '12000-100',
                   description: 'Pequena descrição',
                   owner_id: owner.id
                   )


    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'abc@de.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
    within('nav') do
      expect(page).to have_content 'abc@de.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'and then owner logs out' do
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
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'abc@de.com'

  end

end
