require 'spec_helper'

describe 'echo handler' do
  it 'should echo the message' do
    handler = Huck::Handler::factory :name => 'echo'
    expect(STDOUT).to receive(:puts).with('hello')
    handler.handle 'hello'
  end
end
