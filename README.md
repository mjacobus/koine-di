# Koine::Di

Koine::Di, for your dependency injection
A fork of [Nurse](https://github.com/mjacobus/nurse-rb) under a safer namespace.

Code quality

[![Build Status](https://travis-ci.org/mjacobus/koine-di.svg)](https://travis-ci.org/mjacobus/koine-di)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/koine-di/badge.svg?branch=master)](https://coveralls.io/github/mjacobus/koine-di?branch=master)
[![Code Climate](https://codeclimate.com/github/mjacobus/koine-di/badges/gpa.svg)](https://codeclimate.com/github/mjacobus/koine-di)

Package information

[![Gem Version](https://badge.fury.io/rb/koine-di.svg)](https://badge.fury.io/rb/koine-di)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'koine-di'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install koine-di

## Usage

### Defining dependencies

```ruby
dependency_manager = Koine::Di::DependencyContainer.new

dependency_manager.share(:connection) do |dependency_manager|
  MyConnection.new("mysql://root@localhost/my_db")
end

dependency_manager.share(:user_repository) do |dependency_manager|
  connection = dependency_manager.get(:connection)
  UserRepository.new(connection)
end
```

Also, you can use the singleton instance. Use singleton if you do not have
control over how classes, such as controllers, are created.

```ruby
dependency_manager = Koine::Di.instance
```

### Fetching dependencies
```ruby
class UsersController < SomeBaseController
  def index
    @users = repository.find_all
  end

  private

  def repository
    dependency_manager.get(:user_repository)
  end
end
```

### Using factories

```ruby
class DatabaseConnectionFactory < Koine::Di::ServiceFactory
  share true
  key :db_connection

  def create_service(dependencies)
    DatabaseConnection.new(dependencies.get(:db_config))
  end
end

class UserRepositoryFactory < Koine::Di::ServiceFactory
  key :user_repository

  def create_service(dependencies)
    UserRepository.new(dependencies.get(:db_connection))
  end
end

dependency_manager.add_factory(DatabaseConnectionFactory.new)
dependency_manager.add_factory(UserRepositoryFactory.new)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjacobus/koine-di. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

