require 'rails_helper'

describe 'Owner registers a buffet' do
  it 'Owner clicks on register buffet and sees registration form' do
    # Arrange
    owner = Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')

    # Act
    login_as(owner)
    visit root_path
    click_on "Buffets"
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

  it 'and sees payment methods in the registration form' do
    # Arrange
    owner = Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')
    pix = PaymentMethod.create!(name: 'Pix')
    boleto = PaymentMethod.create!(name: 'Boleto')

    # Act
    login_as(owner)
    visit root_path
    click_on "Buffets"
    click_on 'Cadastrar um Buffet'

    # Assert
    expect(page).to have_content 'Formas de Pagamento'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_content pix.name
    expect(page).to have_content boleto.name

  end

  it 'and payment methods are registered in the database' do
    # Arrange
    owner = Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')
    pix = PaymentMethod.create!(name: 'Pix')
    boleto = PaymentMethod.create!(name: 'Boleto')

    # Act
    login_as(owner)
    visit root_path
    click_on "Buffets"
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
    check pix.name
    check boleto.name
    click_on 'Cadastrar Buffet'

    # Assert
    buffet = Buffet.last
    expect(buffet.payment_methods).not_to eq nil
    expect(buffet.payment_methods).to eq [pix,boleto]

  end

  it 'Successfully' do
      # Arrange
      owner = Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')

      # Act
      login_as(owner)
      visit root_path
      click_on "Buffets"
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


describe 'Owner tries to register a second buffet' do
  it 'and fails for it cannot find buffet registration link ' do
    # Arrange
    owner = Owner.create!(name:'Kratos', email: 'abc@de.com', password: 'password')
    Buffet.create!(brand: 'Kratos Buffet',
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
    click_on 'Buffets'
    
    # Assert
    expect(page).not_to have_link 'Cadastrar um Buffet'
  end
end

describe 'Visitor tries to create a new buffet' do
  it 'and fails for it cannot see create a buffet link' do
    # Arrange
    
    # Act
    visit root_path
    click_on 'Buffets'


    # Assert
    expect(page).not_to have_link 'Cadastrar um Buffet'
  end
end