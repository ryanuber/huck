require 'spec_helper'

describe 'file generator' do
  it 'should return the raw content of a file' do
    file = mktempfile :content => 'test'
    g = Huck::Generator::factory :name => 'file', :config => {'path' => file}
    expect(g.generate).to eq('test')
  end

  it 'should raise if no path is provided' do
    g = Huck::Generator::factory :name => 'file', :config => {}
    expect { g.generate }.to raise_error
  end

  it 'should raise if the file does not exist' do
    g = Huck::Generator::factory :name => 'file', :config => {'path' => '/bad'}
    expect { g.generate }.to raise_error
  end
end
