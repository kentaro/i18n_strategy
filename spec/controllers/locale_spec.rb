require 'spec_helper'

describe RootController do
  before {
    I18nStrategy.strategy = I18nStrategy::Strategy
    I18nStrategy.available_languages = %w[en ja fr]
  }

  describe 'GET /' do
    context 'with no preferred language' do
      before { get :index }

      it {
        expect(response.body).to be == 'en'
      }
    end

    context 'with preferred language from HTTP header' do
      context 'and it is valid' do
        context 'en (default language)' do
          before {
            request.env['HTTP_ACCEPT_LANGUAGE'] = 'en'
            get :index
          }

          it {
            expect(response.body).to be == 'en'
          }
        end

        context 'ja' do
          before {
            request.env['HTTP_ACCEPT_LANGUAGE'] = 'ja'
            get :index
          }

          it {
            expect(response.body).to be == 'ja'
          }
        end
      end

      context 'and it is valid' do
          before {
            request.env['HTTP_ACCEPT_LANGUAGE'] = 'no_such_language'
            get :index
          }

          it {
            expect(response.body).to be == 'en'
          }
      end
    end

    context 'with preferred language from query param' do
      context 'and it is valid' do
        context 'en (default language)' do
          before {
            request.env['HTTP_ACCEPT_LANGUAGE'] = 'ja'
            get :index, :locale => 'en'
          }

          it {
            expect(response.body).to be == 'en'
          }
        end

        context 'fr' do
          before {
            request.env['HTTP_ACCEPT_LANGUAGE'] = 'ja'
            get :index, :locale => 'fr'
          }

          it {
            expect(response.body).to be == 'fr'
          }
        end
      end

      context 'and it is invalid' do
        before {
          request.env['HTTP_ACCEPT_LANGUAGE'] = 'ja'
          get :index, :locale => 'no_such_language'
        }

        it {
          expect(response.body).to be == 'ja'
        }
      end
    end

    context 'with custom strategy' do
      module MyStrategy
        def detect_locale
          'foo'
        end

        def another_detect_locale
          'bar'
        end
      end

      before {
        I18nStrategy.strategy = MyStrategy
      }

      context 'with no preferred method' do
        before {
          get :index
        }

        it {
          expect(response.body).to be == 'foo'
        }
      end

      context 'with preferred method' do
        before {
          I18nStrategy.method_to_detect_locale = :another_detect_locale
          get :index
        }

        it {
          expect(response.body).to be == 'bar'
        }
      end
    end
  end
end
