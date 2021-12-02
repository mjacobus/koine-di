require 'spec_helper'

describe Koine::Di do
  it 'has a version' do
    expect(described_class::VERSION).not_to be_nil
  end

  describe '.instance' do
    it 'returns a singleton instance of DependencyContainer' do
      container = described_class.instance
      expect(container).to be_a(Koine::Di::DependencyContainer)
      expect(container).to eq(described_class.instance)
    end
  end
end
