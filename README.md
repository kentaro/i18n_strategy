# i18n_strategy [![BuildStatus](https://secure.travis-ci.org/kentaro/i18n_strategy.png)](http://travis-ci.org/kentaro/i18n_strategy)

i18n_strategy provides a very much simple way to detect and set locale
in your Rails application.

## Usage

Add a line below into your `Gemfile`:

```
gem 'i18n_strategy'
```

Then, set your custom strategy into `I18nStrategy.strategy`, which is
to detect a locale for a user visiting your application, and also set
available languages in your application via
`I18nStrategy.available_languages`.

`initializers/i18n_strategy`:

```
module MyStrategy
  def detect_locale
    params[:locale]   # just simple and fragile way
  end
end

I18nStrategy.strategy = MyStrategy
I18nStrategy.available_languages = %w[ja en]
```

Users' locale detected by the strategy is automatically set to
`I18n.locale`.

That's all. Very much simple.

## Customization

### I18nStrategy.strategy

Set your own custom strategy module via this method. If not set,
[default strategy](./lib/i18n_strategy/strategy.rb) will be used.

The module must implement `detect_locale` method or some other one set
by `I18nStrategy.method_to_detect_locale` method described below.

### I18nStrategy.method_to_detect_locale

Set another method instead of default one, `detect_locale`.

The method to be used to detect users' locale will be called as a
instance method of a controller which is currently dispatched. That is
to say, it can duplicate your existing method.

In case above, you can set another method name to be called via this
method.

### I18nStrategy.available_languages

Set available language in your application.

The default strategy utilizes this method to detect whether the
language from users can be available in your application or not.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
