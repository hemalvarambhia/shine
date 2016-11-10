require 'rails_helper'
describe 'dashboard/index' do
  include Devise::Test::ControllerHelpers
  
  it 'allows the user to log out' do
    user = create(:user)
    sign_in user
    
    render
    
    expect(rendered).to match /Log Out/
  end
end
