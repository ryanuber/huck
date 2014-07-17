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

describe 'Data Serialization' do
  input = {'a' => 'b'}

  it 'should serialize to json' do
    output = JSON.dump input
    expect(Huck::serialize(input, :format => 'json')).to eq(output)
  end

  it 'should serialize to yaml' do
    output = YAML.dump input
    expect(Huck::serialize(input, :format => 'yaml')).to eq(output)
  end

  it 'should raise on unknown format' do
    expect { Huck::serialize(input, :format => 'bad') }.to raise_error
  end
end

describe 'Parsing Providers' do
  it 'should parse provider hashes correctly' do
    config = [{'provider1' => {'config1' => 'val1'}}, 'provider2']
    i = 0
    Huck::parse_providers config do |name, config|
      case i
      when 0
        expect(name).to eq('provider1')
        expect(config).to eq({'config1' => 'val1'})
      when 1
        expect(name).to eq('provider2')
        expect(config).to be {}
      end
      i += 1
    end
  end

  it 'should raise an error on incorrect provider config' do
    expect { Huck::parse_providers nil }.to raise_error
    expect { Huck::parse_providers [0] }.to raise_error
  end
end
