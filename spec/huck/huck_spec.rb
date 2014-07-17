require 'spec_helper'

describe 'running the client' do
  before(:each) do
    sender = double
    allow(sender).to receive(:send).once
    allow(Huck::Sender).to receive(:factory).and_return(sender)
  end

  it 'should accept config as a hash' do
    config = {'sender' => 'sqs', 'generators' => ['basic']}
    expect(Huck.run :config => config).not_to be_empty
  end

  it 'should read a config file' do
    file = mktempfile :content => <<EOF
sender: sqs
generators:
  - basic
EOF
    expect(Huck.run :config_file => file).not_to be_empty
  end

  it 'should raise if a non-string is generated' do
    expect { Huck.run { 0 } }.to raise_error
  end

end

describe 'running the server' do
  before(:each) do
    receiver = double
    expect(receiver).to receive(:accept).once
    allow(Huck::Receiver).to receive(:factory).and_return(receiver)
  end

  it 'should accept config as a hash' do
    config = {'receiver' => 'sqs', 'handlers' => ['echo']}
    Huck.serve :config => config
  end

  it 'should read a config file' do
    file = mktempfile :content => <<EOF
receiver: sqs
handlers:
  - echo
EOF
    Huck.serve :config_file => file
  end

end
