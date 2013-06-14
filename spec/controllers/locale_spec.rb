require 'spec_helper'

describe RootController do
  before {
    I18nStrategy.strategy = I18nStrategy::Strategy::Default
  }

  describe 'GET /' do
    context 'with no preferred language' do
      before { get :index }

      it {
        expect(response.body).to be == 'en'
      }
    end

    context 'with preferred language' do
      context 'en' do
        before {
          request.env['HTTP_ACCEPT_LANGUAGE'] = 'en,ja;q=0.8,en-US;q=0.6'
          get :index
        }

        it {
          expect(response.body).to be == 'en'
        }
      end

      context 'ja' do
        before {
          request.env['HTTP_ACCEPT_LANGUAGE'] = 'ja,en;q=0.8,en-US;q=0.6'
          get :index
        }

        it {
          expect(response.body).to be == 'ja'
        }
      end
    end

    context 'with preferred language from query param' do
      before {
        request.env['HTTP_ACCEPT_LANGUAGE'] = 'en,ja;q=0.8,en-US;q=0.6'
        get :index, :locale => 'fr'
      }

      it {
        expect(response.body).to be == 'fr'
      }
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

      context 'with no preferred method' do
        before {
          I18nStrategy.strategy = MyStrategy
          get :index
        }

        it {
          expect(response.body).to be == 'foo'
        }
      end

      context 'with preferred method' do
        before {
          I18nStrategy.strategy = MyStrategy
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
