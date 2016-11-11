require 'rails_helper'

RSpec.feature 'User session management', type: :feature do
  let(:user) { create(:user) }
  
  scenario 'User signs out' do
    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'Log Out'

    expect(page).to have_button 'Log in'
  end
end
