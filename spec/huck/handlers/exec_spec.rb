require 'spec_helper'

describe 'exec handler' do
  it 'should raise if no command provided' do
    h = Huck::Handler::factory :name => 'exec'
    expect { h.verify_config }.to raise_error
  end

  it 'should execute a command and return its output' do
    file = mktempfile
    config = {'command' => "cat >> #{file}"}
    h = Huck::Handler::factory :name => 'exec', :config => config
    h.handle 'hello'
    expect(open(file).read).to eq('hello')
  end
end
