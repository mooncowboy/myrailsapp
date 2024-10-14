require 'spec_helper'

RSpec.describe 'Hello World' do
  it 'prints hello world' do
    expect('Hello World').to eq('Hello World')
  end
end