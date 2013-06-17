# i18n_strategy [![BuildStatus](https://secure.travis-ci.org/kentaro/i18n_strategy.png)](http://travis-ci.org/kentaro/i18n_strategy)

i18n_strategy provides a very much simple way to detect and set locale
in your Rails application.

In
[i18n section of Rails Guide](http://edgeguides.rubyonrails.org/i18n.html),
there's a description on Rails i18n API. It's comprehensive and has
enough information to implement our own locale detection
strategy. However, it doesn't provide us some automatic way to handle
users' locale.

I've wanted some easier way to handle it. So I hacked up this library
which provides a thin wrapper over Rails i18n API and allows you to
detect and set request users' locale easily.

## Usage

Add a line below into your `Gemfile`:

```ruby
gem 'i18n_strategy'
```

Then, set your custom strategy into `I18nStrategy.strategy`, which is
to detect a locale for a user visiting your application, and also set
available languages in your application via
`I18nStrategy.available_locales`.

`initializers/i18n_strategy`:

```ruby
# Just for example
module MyStrategy
  def detect_locale
    if params[:local] && I18nStrategy.available_locales.include?(params[:locale])
      params[:locale]
    else
      I18n.default_locale
    end
  end
end

I18nStrategy.strategy = MyStrategy
I18nStrategy.available_locales = %w[ja en]
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

### I18nStrategy.available_locales

Set available locales in your application.

The default strategy utilizes this method to detect whether the
language from users can be available in your application or not.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
