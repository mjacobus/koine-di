require 'spec_helper'

describe Koine::Di do
  it 'has a version' do
    refute_nil ::Koine::Di::VERSION
  end

  describe '.instance' do
    it 'returns a singleton instance of DependencyContainer' do
      container = Koine::Di.instance
      container.must_be_instance_of(Koine::Di::DependencyContainer)
      Koine::Di.instance.must_be_same_as(container)
    end
  end
end
