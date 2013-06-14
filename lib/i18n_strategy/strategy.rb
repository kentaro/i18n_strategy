module I18nStrategy
  module Strategy

    # This strategy is put here for just testing. You should use it
    # directly, but should implement your own strategy
    module Default
      def detect_locale
        lang = nil

        if params[:locale]
          lang = params[:locale]
        else
          header = request.env['HTTP_ACCEPT_LANGUAGE'] || ''
          lang   = header.scan(/^[a-z]{2}/).first
        end

        lang || I18n.default_locale
      end
    end
  end
end
