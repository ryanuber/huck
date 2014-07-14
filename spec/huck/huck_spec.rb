require 'huck'
require 'aws-sdk'
#AWS::Stub!

describe 'Running Huck Client' do
  it 'should run the client without errors' do
    Huck.run
  end
end
