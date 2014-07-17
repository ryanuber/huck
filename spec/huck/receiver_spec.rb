require 'spec_helper'

describe 'getting receiver instances' do
  it 'should return the sqs receiver' do
    expect(Huck::Receiver::factory :name => 'sqs').to(
      be_a Huck::Receivers::SQSReceiver)
  end

  it 'should return the rabbitmq receiver' do
    expect(Huck::Receiver::factory :name => 'rabbitmq').to(
      be_a Huck::Receivers::RabbitMQReceiver)
  end

  it 'should raise on invalid receiver' do
    expect { Huck::Receiver::factory :name => 'bad' }.to raise_error
  end
end

describe 'accepting messages from queues' do
  it 'should accept a message and hand it to the handler' do
    h = double
    allow(h).to receive(:handle)
    r = Huck::Receiver::factory :name => 'sqs'
    allow(r).to receive(:receive).and_yield('test')
    r.accept [h], nil
  end

  it 'should dump an error message on handler error' do
    h = double
    expect(STDOUT).to receive(:puts).with('Handler error (RSpec::Mocks::Double): RuntimeError')
    allow(h).to receive(:handle).and_raise(RuntimeError)
    r = Huck::Receiver::factory :name => 'sqs'
    allow(r).to receive(:receive).and_yield('test')
    r.accept [h], nil
  end
end
