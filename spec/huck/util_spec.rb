require 'spec_helper'

describe 'Huck Configuration' do
  it 'should read the proper default config file' do
    path = File.join Dir.home, 'huck.conf'
    if !File.exist? path
      f = File.open path, 'w'
      f.write '{"test": "config"}'
      f.close
    end
    expect(Huck.config).not_to be_empty
    File.delete f.path if f
  end

  it 'should accept an alternate config file path' do
    file = mktempfile "test: config\n"
    expect(Huck.config :path => file).to eq({'test' => 'config'})
  end
end

describe 'Module Loading' do
  it 'should return true when module is loaded' do
    expect(Huck::try_load 'yaml').to be true
  end

  it 'should return false when module cannot be loaded' do
    expect(Huck::try_load 'nonexistent').to be false
  end

  it 'should not raise when module is loaded' do
    expect{Huck::must_load 'yaml'}.not_to raise_error
  end

  it 'should raise a RuntimeError when module cannot be loaded' do
    expect{Huck::must_load 'nonexistent'}.to raise_error(RuntimeError)
  end
end
