require 'spec_helper'

describe 'stdin generator' do
  it 'should collect data from stdin' do
    g = Huck::Generator::factory :name => 'stdin'

    g.stdin = StringIO.new
    g.stdin.puts 'test'
    g.stdin.rewind

    expect(g.generate).to eq("test\n")
  end
end
