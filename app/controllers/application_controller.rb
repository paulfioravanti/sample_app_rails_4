class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  # Every helper method dependent on url_for (e.g. helpers for named
  # routes like root_path or root_url, resource routes like books_path
  # or books_url, etc.) will now automatically include the locale in
  # the query string,
  def url_options
    { locale: I18n.locale }.merge(super)
  end

  private

    def signed_in?
      !current_user.nil?
    end
    helper_method :signed_in?

    def current_user
      nil
      # @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end
    helper_method :current_user

    def set_locale
      I18n.locale = params[:set_locale] || params[:locale]
    end
end
