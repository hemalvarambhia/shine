require 'rails_helper'
describe 'dashboard/index' do
  include Devise::Test::ControllerHelpers
  
  it 'allows the user to log out' do
    user = User.create(email: 'test_user@example.com', password: 'secretpassword')
    sign_in user
    
    render
    
    expect(rendered).to match /Log Out/
  end
end
