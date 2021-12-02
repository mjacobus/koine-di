require 'spec_helper'

describe Koine::Di::SharedServiceFactory do
  let(:config) { Hash.new(foo: :bar) }

  let(:factory) do
    Class.new(described_class) do
      key :the_key

      def create_service(dependency_manager)
        Array.new([dependency_manager.get(:config)])
      end

      def self.share(*args)
        super
      end
    end
  end

  let(:container) do
    container = Koine::Di::DependencyContainer.new
    container.share(:config) { config }
    container.add_factory(factory.new)
    container
  end

  it 'attaches to dependency_manager' do
    service = container.get(:the_key)

    expect(service).to eq(Array.new([config]))
    expect(container.get(:the_key)).to equal(service)
  end

  it 'extends ServiceFactory' do
    expect(factory.new).to be_a(Koine::Di::ServiceFactory)
  end

  it 'is not shared' do
    expect(factory.new.shared?).to eq(true)
  end

  describe '#share' do
    it 'raises an exception when factory is already shared' do
      expect { factory.share('shared') }.to raise_error do |error|
        expect(error).to be_a(RuntimeError)
        expect(error.message).to eq('You cannot change the shared state of a shared service factory. Extend Nurse::ServiceFactory instead')
      end
    end
  end
end
