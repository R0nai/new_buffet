require 'rails_helper'

describe 'Owner edits buffet' do
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
      fill_in 'E-mail', with: owner.email
      fill_in 'Senha', with: owner.password
      click_on 'Entrar'
    end
    click_on "Buffets"
    click_on "Kratos Buffet"
    click_on "Editar Buffet"

    # Assert
    expect(page).to have_content "Editar Buffet"
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

  it 'owner tries to edit buffet that is not his and cannot find edit link' do
    # Arrange
    owner = Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')
    other_owner = Owner.create!(name:'Goku', email: 'goku@dbz.com', password: 'password')
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
      fill_in 'E-mail', with: other_owner.email
      fill_in 'Senha', with: other_owner.password
      click_on 'Entrar'
    end
    click_on "Buffets"
    click_on "Kratos Buffet"

    # Assert
    expect(page).not_to have_link "Editar Buffet"
  end

  it "Visitor cannot find buffet's edit link" do
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
    click_on "Buffets"
    click_on "Kratos Buffet"

    # Assert
    expect(page).not_to have_link "Editar Buffet"
  end
end