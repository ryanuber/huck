require 'spec_helper'

describe 'getting generator instances' do
  it 'should return the basic generator' do
    expect(Huck::Generator::factory :name => 'basic').to(
      be_a Huck::Generators::BasicGenerator)
  end

  it 'should return the facter generator' do
    expect(Huck::Generator::factory :name => 'facter').to(
      be_a Huck::Generators::FacterGenerator)
  end

  it 'should return the ohai generator' do
    expect(Huck::Generator::factory :name => 'ohai').to(
      be_a Huck::Generators::OhaiGenerator)
  end

  it 'should return the file generator' do
    expect(Huck::Generator::factory :name => 'file').to(
      be_a Huck::Generators::FileGenerator)
  end

  it 'should return the exec generator' do
    expect(Huck::Generator::factory :name => 'exec').to(
      be_a Huck::Generators::ExecGenerator)
  end

  it 'should raise on invalid generator' do
    expect { Huck::Generator::factory :name => 'bad' }.to raise_error
  end
end
