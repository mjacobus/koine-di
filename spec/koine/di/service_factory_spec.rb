require 'spec_helper'

describe Koine::Di::ServiceFactory do
  let(:config) { Hash.new(foo: :bar) }

  let(:invalid_factory) do
    Class.new(Koine::Di::ServiceFactory).new
  end

  let(:factory) do
    Class.new(Koine::Di::ServiceFactory) do
      key :the_key

      def create_service(dependency_manager)
        Array.new([dependency_manager.get(:config)])
      end
    end
  end

  let(:shared_factory) do
    Class.new(Koine::Di::ServiceFactory) do
      share true
      key :shared_key

      def create_service(dependency_manager)
        Array.new([dependency_manager.get(:config)])
      end
    end
  end

  let(:container) do
    container = Koine::Di::DependencyContainer.new
    container.share(:config) { config }
    container.add_factory(factory.new)
    container.add_factory(shared_factory.new)
    container
  end

  describe 'when it is not a shared dependency' do
    it 'attaches to dependency_manager' do
      service = container.get(:the_key)

      expect(service).to eq(Array.new([config]))
      expect(container.get(:the_key)).not_to equal(service)
    end

    it 'is not shared?' do
      expect(factory.new.shared?).to eq(false)
    end

    it 'raises error when #dependency_key is not overriden' do
      expect { invalid_factory.dependency_key }.to raise_error do |error|
        expect(error).to be_a(RuntimeError)
        expect(error.message).to eq('dependency_key must be implemented')
      end
    end

    it 'raises error when #create_service is not overriden' do
      expect { invalid_factory.create_service([]) }.to raise_error do |error|
        expect(error).to be_a(RuntimeError)
        expect(error.message).to eq('create_service must be implemented')
      end
    end
  end

  describe 'when it is shared' do
    it 'attaches to dependency_manager as a non shared resource' do
      service = container.get(:shared_key)

      expect(service).to eq(Array.new([config]))

      expect(container.get(:shared_key)).to equal(service)
    end

    it 'extends ServiceFactory' do
      expect(shared_factory.new).to be_a(Koine::Di::ServiceFactory)
    end

    it 'is shared' do
      expect(shared_factory.new.shared?).to eq(true)
    end
  end
end
