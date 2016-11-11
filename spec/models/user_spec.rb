require 'rails_helper'

describe 'User account' do
  context 'with a password less than 10 characters long' do
    it 'is invalid'
  end

  context 'with a password more than 128 characters long' do
    it 'is invalid'
  end
end
