require 'spec_helper'

describe 'sqs sender' do
  before(:each) do
    allow(Huck).to receive(:must_load)
    sqs = double
    queues = double
    allow(sqs).to receive(:queues).and_return(queues)
    queue = double
    allow(queue).to receive(:send_message).with('test')
    allow(queues).to receive(:create).with('q').and_return(queue)
    allow(AWS::SQS).to receive(:new).with(
      :access_key_id => 'i',
      :secret_access_key => 's',
      :region => 'r'
    ).and_return(sqs)
  end

  it 'should raise if no sqs config provided' do
    s = Huck::Sender::factory :name => 'sqs', :config => {}
    expect { s.send 'test' }.to raise_error
  end

  it 'should raise if not all required config provided' do
    config = {'sqs' => {'access_key_id' => 'test', 'region' => 'test'}}
    s = Huck::Sender::factory :name => 'sqs', :config => config
    expect { s.send 'test' }.to raise_error
  end

  it 'should call the aws sdk to send a message' do
    config = {'sqs' => {'access_key_id' => 'i', 'region' => 'r',
                        'secret_access_key' => 's', 'queue_name' => 'q'}}
    s = Huck::Sender::factory :name => 'sqs', :config => config
    s.send 'test'
  end

end
