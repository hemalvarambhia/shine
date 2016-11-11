require 'rails_helper'

describe 'User account' do
  context 'with a password less than 10 characters long' do
    it 'is invalid' do
      user = build(:user, password: 'a' * 9)

      expect(user).not_to be_valid
    end
  end

  context 'with a password more than 128 characters long' do
    it 'is invalid'
  end
end
