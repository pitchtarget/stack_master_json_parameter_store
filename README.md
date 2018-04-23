# StackMasterJsonParameterStore

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/stack_master_json_parameter_store`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'stack_master_json_parameter_store'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stack_master_json_parameter_store

## Usage

If your parameter called `/aws/service/ecs/optimized-ami/amazon-linux/recommended` and you want to use the value of the `image_id` key. For example:

```json
{
  "schema_version": 1,
  "image_name": "amzn-ami-2017.09.l-amazon-ecs-optimized",
  "image_id": "ami-2d386654"
}
```

You use the `json_parameter_store_resolver` with the format `<parameter path>#<JMESPath>` where `#` is used to separate the two paths.

Example:

```json
AmiId:
  json_parameter_store_resolver: /aws/service/ecs/optimized-ami/amazon-linux/recommended#image_id
```

To get an introduction to jmespath go to [jmespath tutorial](http://jmespath.org/tutorial.html) 

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/stack_master_json_parameter_store. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the StackMasterJsonParameterStore project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/stack_master_json_parameter_store/blob/master/CODE_OF_CONDUCT.md).
