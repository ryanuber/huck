require 'spec_helper'

describe 'basic generator' do
  before(:each) do
    stub_const('RUBY_PLATFORM', 'linux')
    allow(Socket).to receive(:gethostname).and_return('test')
  end

  it 'should return json by default' do
    g = Huck::Generator::factory :name => 'basic', :config => {}
    expect(g.generate).to eq('{"hostname":"test","platform":"linux"}')
  end

  it 'should return json on request' do
    g = Huck::Generator::factory :name => 'basic', :config => {'format' => 'json'}
    expect(g.generate).to eq('{"hostname":"test","platform":"linux"}')
  end

  it 'should return yaml on request' do
    g = Huck::Generator::factory :name => 'basic', :config => {'format' => 'yaml'}
    expect(g.generate).to eq("---\nhostname: test\nplatform: linux\n")
  end

  it 'should raise on invalid format' do
    g = Huck::Generator::factory :name => 'basic', :config => {'format' => 'bad'}
    expect { g.generate }.to raise_error
  end
end
