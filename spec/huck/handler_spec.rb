require 'spec_helper'

describe 'getting handler instances' do
  it 'should return the echo handler' do
    expect(Huck::Handler::factory :name => 'echo').to be_a Huck::Handlers::EchoHandler
  end

  it 'should return the exec handler' do
    expect(Huck::Handler::factory :name => 'exec').to be_a Huck::Handlers::ExecHandler
  end

  it 'should raise if no valid handlers found' do
    expect { Huck::Handler::factory :name => 'bad' }.to raise_error
  end
end
