require 'spec_helper'

describe 'sqs receiver' do
  before(:each) do
    allow(Huck).to receive(:must_load)
    sqs = double
    queues = double
    allow(sqs).to receive(:queues).and_return(queues)
    queue = double
    msg = double(:body => 'test')
    allow(queue).to receive(:poll).and_yield(msg)
    allow(queues).to receive(:create).with('q').and_return(queue)
    allow(AWS::SQS).to receive(:new).with(
      :access_key_id => 'i',
      :secret_access_key => 's',
      :region => 'r'
    ).and_return(sqs)
  end

  it 'should raise if no sqs config provided' do
    r = Huck::Receiver::factory :name => 'sqs', :config => {}
    expect { r.receive }.to raise_error
  end

  it 'should raise if not all required config provided' do
    config = {'sqs' => {'access_key_id' => 'test', 'region' => 'test'}}
    r = Huck::Receiver::factory :name => 'sqs', :config => config
    expect { r.receive }.to raise_error
  end

  it 'should call the aws sdk to poll messages' do
    config = {'sqs' => {'access_key_id' => 'i', 'region' => 'r',
                        'secret_access_key' => 's', 'queue_name' => 'q'}}
    r = Huck::Receiver::factory :name => 'sqs', :config => config
    expect { |b| r.receive(&b) }.to yield_with_args('test')
  end

end
