require 'action_controller/railtie'

module I18nStrategyTestApp
  class Application < Rails::Application
    config.default_locale = 'en'
    config.active_support.deprecation = :log
  end
end

I18nStrategyTestApp::Application.initialize!

# routes
I18nStrategyTestApp::Application.routes.draw do
  root :to => 'root#index'
end

# controllers
class ApplicationController < ActionController::Base
end

class RootController < ApplicationController
  def index
    render :text => I18n.locale
  end
end
