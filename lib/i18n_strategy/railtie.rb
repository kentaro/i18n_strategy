module I18nStrategy
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'i18n_strategy' do |app|
      I18nStrategy::Initializer.init
    end
  end
end
