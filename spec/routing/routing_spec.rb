require 'rails_helper'

describe '1 + 1' do
  it 'is equal to 2' do
    expect(1 + 1).to eq 2
  end
end

describe '/', type: :routing do
  it 'routes to the dashboard controller' do
    expect(get('/')).to route_to 'dashboard#index'
  end
end

describe '/customers', type: :routing do
  it 'routes to the customer controller index action'
end
