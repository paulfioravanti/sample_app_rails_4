# Allow for methods in ApplicationHelper to be tested
include ApplicationHelper

def all_locales(&block)
  I18n.available_locales.each do |locale|
    yield(locale)
  end
end

def all_locales_to_all_other_locales(&block)
  I18n.available_locales.each do |locale|
    I18n.locale = locale
    I18n.available_locales.each do |target_locale|
      next if locale == target_locale
      yield(locale, target_locale)
    end
  end
end

def current_locale
  I18n.locale
end

def fill_in_fields_with(user, new_name = nil, new_email = nil)
  scope = 'activerecord.attributes.user'
  password = user.password
  fill_in t(:name, scope: scope),     with: new_name || user.name
  fill_in t(:email, scope: scope),    with: new_email || user.email
  fill_in t(:password, scope: scope), with: password
  fill_in t(:password_confirmation, scope: scope), with: password
end

def sign_in!(locale, user, options={})
  if options[:via_request]
    post session_path(locale, email: user.email, password: user.password)
    remember_token = User.new_remember_token
    cookies[:remember_token] = User.encrypt(remember_token)
  else
    visit signin_path(locale) unless current_path == signin_path(locale)
    scope = 'sessions.new'
    fill_in t(:email, scope: scope),    with: user.email
    fill_in t(:password, scope: scope), with: user.password
    click_button t(:sign_in, scope: scope)
  end
end

def invalid_email_addresses
  %w[user@foo,com user_at_foo.org example.user@foo.
    foo@bar_baz.com foo@bar+baz.com]
end

def valid_email_addresses
  %w[user@foo.com A_USER@f.b.org frst.lst@foo.jp a+b@baz.cn]
end

def t(string, options = {})
  I18n.t(string, options)
end