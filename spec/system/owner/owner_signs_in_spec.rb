require 'rails_helper'

describe 'Owner signs-in' do
  it 'Sucessfully' do
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
