require 'spec_helper'

describe 'exec generator' do
  it 'should return the output of a command' do
    g = Huck::Generator::factory :name => 'exec', :config => {'command' => 'echo hi'}
    expect(g.generate).to eq("hi\n")
  end

  it 'should raise if no command is given' do
    g = Huck::Generator::factory :name => 'exec', :config => {}
    expect { g.generate }.to raise_error
  end
end
