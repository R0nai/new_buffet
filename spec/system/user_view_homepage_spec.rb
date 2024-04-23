require 'rails_helper'

describe 'User visits homepage' do
  it 'and sees app name' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Cadê Buffet'
  end

  it 'and sees buffet link' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_link 'Buffets'
  end

end