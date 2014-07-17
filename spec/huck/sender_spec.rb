require 'spec_helper'

describe 'getting sender instances' do
  it 'should return the sqs sender' do
    expect(Huck::Sender::factory :name => 'sqs').to(
      be_a Huck::Senders::SQSSender)
  end

  it 'should return the rabbitmq sender' do
    expect(Huck::Sender::factory :name => 'rabbitmq').to(
      be_a Huck::Senders::RabbitMQSender)
  end

  it 'should raise on invalid sender' do
    expect { Huck::Sender::factory :name => 'bad' }.to raise_error
  end
end
