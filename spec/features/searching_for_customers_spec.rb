require 'rails_helper'

describe 'Searching for customers' do
  let(:user) { create :user }
  
  it 'allows the user to enter a search term' do
    visit '/customers'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_selector('input', id: 'keywords')
  end
  
  it 'finds customers by matching first name'

  it 'finds customers by matching last name'

  it 'finds customers by their e-mail address'
end
