require 'spec_helper'

describe Koine::Di::DependencyContainer do
  let(:shared) { {} }
  let(:new_hash) { Hash.new(foo: :bar) }

  let(:container) do
    container = Koine::Di::DependencyContainer.new
    container.share(Hash) { {} }
    container.share(:definition) { :defined_object }
    container.share(:shared) { shared }
    container.set(:new_hash) { new_hash.dup }
  end

  describe '#defined?' do
    it 'returns false when it was not defined' do
      expect(container.defined?(:undefined)).to eq(false)
    end

    it 'returns true when it was defined with #share' do
      expect(container.defined?(:shared)).to eq(true)
      expect(container.defined?('shared')).to eq(true)
    end

    it 'returns true when it was defined with #set' do
      expect(container.defined?(:new_hash)).to eq(true)
      expect(container.defined?('new_hash')).to eq(true)
    end
  end

  describe '#share' do
    it 'raises error when dependency is already defined' do
      expect { container.share(:shared) }.to raise_error do |error|
        expect(error).to be_a(Koine::Di::DependencyContainer::DependencyAlreadyDefined)
        expect(error.message).to eq("Dependency 'shared' was already defined")
      end
    end
  end

  describe '#set' do
    it 'raises error when dependency is already defined' do
      expect { container.share(:new_hash) }.to raise_error do |error|
        expect(error).to be_a(Koine::Di::DependencyContainer::DependencyAlreadyDefined)
        expect(error.message).to eq("Dependency 'new_hash' was already defined")
      end
    end
  end

  describe '#get' do
    it 'returns the same instance when it was defined with #share' do
      expect(container.get(:shared)).to equal(shared)
      expect(container.get('shared')).to equal(container.get(:shared))
    end

    it 'returns a different instance when it was defined with #set' do
      expect(container.get(:new_hash)).not_to equal(new_hash)
      expect(container.get(:new_hash)).not_to equal(container.get('new_hash'))
      expect(container.get(:new_hash)).to eq(new_hash)
    end

    it 'returns block if dependency is not defined and block is given' do
      expect(container.get(:undefined) { :foo }).to eq(:foo)
    end

    it 'raises an exception when dependency is not defined' do
      expect { container.get('undefined') }.to raise_error do |error|
        expect(error).to be_a(Koine::Di::DependencyContainer::UndefinedDependency)
        expect(error.message).to eq("'undefined' was not defined")
      end
    end
  end
end
