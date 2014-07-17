require 'spec_helper'

module Facter
  def to_hash
  end
end

describe 'facter generator' do
  it 'should call facter to get facts' do
    allow(Huck).to receive(:must_load)
    g = Huck::Generator::factory :name => 'facter', :config => {}
    expect(Facter).to receive(:to_hash).once
    g.generate
  end
end
