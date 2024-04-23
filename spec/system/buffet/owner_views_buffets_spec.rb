require 'rails_helper'

describe 'Owner sees buffets' do
  it 'successfully' do
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
    login_as(owner)
    visit root_path
    click_on 'Buffets'

    # Assert
    expect(page).to have_link 'Kratos Buffet'

  end
end