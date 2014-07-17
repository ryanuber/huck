require 'spec_helper.rb'

module Ohai
  class System
  end
end

describe 'ohai generator' do
  before(:each) do
    allow(Huck).to receive(:must_load)
    ohai_system = double
    allow(Ohai::System).to receive(:new).and_return(ohai_system)
    allow(ohai_system).to receive(:all_plugins)
    allow(ohai_system).to receive(:json_pretty_print).and_return('{"a":"b"}')
  end

  it 'should return json by default' do
    g = Huck::Generator::factory :name => 'ohai', :config => {}
    expect(g.generate).to eq('{"a":"b"}')
  end

  it 'should return json upon request' do
    g = Huck::Generator::factory :name => 'ohai', :config => {'format' => 'json'}
    expect(g.generate).to eq('{"a":"b"}')
  end

  it 'should return yaml upon request' do
    g = Huck::Generator::factory :name => 'ohai', :config => {'format' => 'yaml'}
    expect(g.generate).to eq("---\na: b\n")
  end
end
