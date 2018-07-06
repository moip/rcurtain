# RCurtain

![SimpleCov](/coverage/coverage.svg)

Easy way to control your features using [redis](http://redis.io/).

Also available for Java -> [JCurtain!](https://github.com/moip/jcurtain)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rcurtain'
```

And then execute:

```
    $ bundle install
```

Or install it yourself as:

```
    $ gem install rcurtain
```

## Usage

### Configuration

1. Initialize the configuration to define your **redis URL**

```ruby
RCurtain.configure do |config|
  # URL format -> redis://<password>@<ip>:<port>/<database>
  config.url = 'redis://:p4ssw0rd@10.0.1.1:6380/15'
end
```

2. Configure the **default response** of the service (Optional)

```ruby
RCurtain.configure do |config|
  # Default response when the feature is not found. Default: false
  config.default_response = true
end
```

3. Configure the **feature name format** (Optional)

```ruby
RCurtain.configure do |config|
  # Default format of the keys that will be saved to redis. Default: feature:<name>:
  config.feature_name_format = '<name>:'
end
```

4. Configure the **default description** (Optional)

```ruby
RCurtain.configure do |config|
  # Default description of the feature
  config.default_description = 'Description'
end
```

5. Configure the **default percentage** (Optional)
```ruby
RCurtain.configure do |config|
  # Default percentage to be returned when percentage is not set
  config.default_percentage = 'Description'
end
```

6. Configure if RCurtain should **save users** when using percentage
```ruby
RCurtain.configure do |config|
  # Should users be persisted when allowed by percentage?
  config.save_users = false
end
```

RCurtain uses a **percentage** or a **set of users** to control the features:
```ruby
# Percentage
feature:<name>:percentage

# Set of users
feature:<name>:users
```

The `percentage` and `users` parameters will be added to the feature name format you configured before.

### Checking the features

1. Get the instance of RCurtain
```ruby
rcurtain = RCurtain.instance
```

2. Check if a feature is enabled or not
```ruby
rcurtain.opened?('feature-name')
```

3. Or check if the feature is enabled for specific users
```ruby
rcurtain.opened?('feature-name', ['user-1', 'user-2'])
```

4. You can also retrieve a list of users that have that feature enabled
```ruby
RCurtain.feature.array('feature-name')
```

5. Or check the percentage for that feature
```ruby
RCurtain.feature.number('feature-name')
```

### Controlling the features

1. Enable a feature for specific users
```ruby
RCurtain.feature.add('feature-name', ['user-1', 'user-2'])
```

2. Disable a feature for specific users
```ruby
RCurtain.feature.remove('feature-name', ['user-2'])
```

3. Update the percentage for a feature
```ruby
RCurtain.feature.update('percentage', 50)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moip/rcurtain. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it (https://github.com/moip/rcurtain/fork)
2. Create your feature branch

```
git checkout -b my-new-feature
```

3. Commit your changes

```
git commit -am 'Add some feature'
```

4. Push to the branch

```
git push origin my-new-feature
```

5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
