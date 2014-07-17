require 'spec_helper'

module Facter
  def to_hash
  end
end

describe 'facter generator' do
  before(:each) do
    allow(Huck).to receive(:must_load)
    allow(Facter).to receive(:to_hash).and_return({'a' => 'b'})
  end

  it 'should return json by default' do
    g = Huck::Generator::factory :name => 'facter', :config => {}
    expect(g.generate).to eq('{"a":"b"}')
  end

  it 'should return json upon request' do
    g = Huck::Generator::factory :name => 'facter', :config => {'format' => 'json'}
    expect(g.generate).to eq('{"a":"b"}')
  end

  it 'should return yaml upon request' do
    g = Huck::Generator::factory :name => 'facter', :config => {'format' => 'yaml'}
    expect(g.generate).to eq("---\na: b\n")
  end
end
