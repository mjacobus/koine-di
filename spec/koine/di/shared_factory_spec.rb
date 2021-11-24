require 'spec_helper'

describe Koine::Di::ServiceFactory do
  let(:config) { Hash.new(foo: :bar) }

  let(:factory) do
    Class.new(Koine::Di::SharedServiceFactory) do
      key :the_key

      def create_service(dependency_manager)
        Array.new([dependency_manager.get(:config)])
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

    service.must_equal(Array.new([config]))
    container.get(:the_key).must_be_same_as(service)
  end

  it 'extends ServiceFactory' do
    factory.new.is_a?(Koine::Di::ServiceFactory).must_equal true
  end

  it 'is not shared' do
    factory.new.shared?.must_equal true
  end
end
