shared_context "authentication" do |locale|
  given(:sign_in_page_title) { t('sessions.new.sign_in') }
  given(:sign_out)           { t('layouts.account_dropdown.sign_out') }
  given(:user)               { create(:user) }
end

shared_context "user sign in" do |locale|
  include_context "authentication", locale
  given(:sign_in)            { t('sessions.new.sign_in') }
  given(:sign_in_heading)    { sign_in }
  given(:invalid)            { t('flash.invalid_credentials') }
  given(:home)               { t('layouts.header.home') }
  given(:user)               { create(:user) }
  background { visit signin_path(locale) }
end

shared_context "authorization" do |locale|
  include_context "authentication", locale
  given(:edit_user_page)       { edit_user_path(locale, user) }
  given(:edit_user_page_title) { t('users.edit.edit_user') }
  given(:sign_in)              { t('layouts.header.sign_in') }
  given(:sign_in_notice)       { t('flash.sign_in') }
  given(:user_index_page)      { users_path(locale) }
  given(:user_following_page)  { following_user_path(locale, user) }
  given(:user_followers_page)  { followers_user_path(locale, user) }
  given(:wrong_user)           { create(:user) }
  given(:edit_wrong_user_page) { edit_user_path(locale, wrong_user) }
  given(:edit_user_page_title) { t('users.edit.edit_user') }
  given(:sign_in_page)         { signin_path(locale) }
end