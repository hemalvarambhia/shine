require 'rails_helper'

describe 'User account' do
  context 'with a password less than 10 characters long' do
    it 'is invalid' do
      user = build(:user, password: 'a' * 9)

      expect(user).not_to be_valid
    end
  end

  context 'with a password more than 128 characters long' do
    it 'is invalid' do
      user_with_too_long_password =
        build(:user, password: 'a' * 129)
      
      expect(user_with_too_long_password).not_to be_valid
    end
  end

  context 'with an email that is not the company one' do
    it 'is invalid' do
      with_non_company_email =
        build(:user, email: 'user2302@notcompany.com')
      
      expect(with_non_company_email).not_to be_valid
    end
  end
end
