class ApplicationController < ActionController::Base
  include Localizeable, Authenticatable

  protect_from_forgery with: :exception

  # Every helper method dependent on url_for (e.g. helpers for named
  # routes like root_path or root_url, resource routes like books_path
  # or books_url, etc.) will now automatically include the locale in
  # the query string,
  def url_options
    { locale: I18n.locale }.merge(super)
  end
end