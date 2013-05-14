module Authenticatable
  def self.included(base)
    base.send :helper_method, :sign_in, :signed_in?, :signed_in_user,
      :sign_out, :current_user, :current_user=, :current_user?
  end

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location # to redirect to original page after signin
      redirect_to signin_url, notice: t('flash.sign_in')
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def store_location
    session[:return_to] = request.url
  end
end