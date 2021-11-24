require 'koine/di/version'
require 'koine/di/dependency_container'
require 'koine/di/service_factory'
require 'koine/di/shared_service_factory'

module Koine
  module Di
    def self.instance
      @instance ||= Koine::Di::DependencyContainer.new
    end
  end
end
