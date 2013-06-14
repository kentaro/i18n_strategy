require 'http_accept_language/parser'

module I18nStrategy
  module Strategy
    module Default
      def detect_locale
        lang      = nil
        available = I18nStrategy.available_languages || []

        if params[:locale] && available.include?(params[:locale])
          lang = params[:locale]
        else
          parser = HttpAcceptLanguage::Parser.new(request.env['HTTP_ACCEPT_LANGUAGE'])
          lang   = parser.preferred_language_from(available)
        end

        lang || I18n.default_locale
      end
    end
  end
end
