module I18nStrategy
  mattr_accessor :strategy, :method_to_detect_locale, :available_languages

  class Initializer
    def self.init(app)
      I18nStrategy.strategy ||= I18nStrategy::Strategy

      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send(:include, Filter)
      end
    end
  end

  module Filter
    extend ActiveSupport::Concern

    included do
      append_before_filter :set_locale
    end

    def set_locale
      extend(I18nStrategy.strategy)
      I18n.locale = send(I18nStrategy.method_to_detect_locale || :detect_locale)
    end
  end
end
