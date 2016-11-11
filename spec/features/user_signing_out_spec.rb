require 'rails_helper'

RSpec.feature 'User session management', type: :feature do
  before :each do
    User.create(email: 'test_user@example.com', password: 'secretpassword')
  end
  
  scenario 'User signs out' do
    visit '/'
    fill_in 'Email', with: 'test_user@example.com'
    fill_in 'Password', with: 'secretpassword'
    click_button 'Log in'

    click_link 'Log Out'

    expect(page).to have_button 'Log in'
  end
end
