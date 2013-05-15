shared_context "locale switching" do |locale, target_locale|
  given(:current_locale_page_title) { t('layouts.application.base_title') }
  given(:target_language) { t("layouts.locale_selector.#{target_locale}") }
  given(:target_locale_page_title) do
    t('layouts.application.base_title', locale: target_locale)
  end
  background { visit locale_root_path(locale) }
end

shared_context "user list for pagination" do |locale, target_locale|
  include_context "sign in a user", locale
  background              { visit users_path(locale) }
  given(:next_page)       { t('will_paginate.next_label') }
  given(:target_language) { t("layouts.locale_selector.#{target_locale}") }
  given(:page_two)        { %r(\?page=2) }
  background do
    create_list(:user, 30)
    visit users_path(locale)
  end
end

shared_context "locale validation errors" do |locale, target_locale|
  given(:user)                 { create(:user) }
  given(:home_page)            { locale_root_path(locale) }
  given(:home_page_title)      { t('layouts.application.base_title') }
  given(:post_button)          { t('shared.micropost_form.post') }
  given(:target_language)      { t("layouts.locale_selector.#{target_locale}") }
  given(:sign_in_page)         { signin_path(locale) }
  given(:sign_in_page_title)   { t('sessions.new.sign_in') }
  given(:sign_in)              { t('sessions.new.sign_in') }
  given(:sign_up_page)         { signup_path(locale) }
  given(:sign_up_page_title)   { t('users.new.sign_up') }
  given(:create_account)       { t('users.new.create_account') }
  given(:edit_user_page)       { edit_user_path(locale, user) }
  given(:edit_user_page_title) { t('users.edit.edit_user') }
  given(:save_changes)         { t('users.edit.save_changes') }
end