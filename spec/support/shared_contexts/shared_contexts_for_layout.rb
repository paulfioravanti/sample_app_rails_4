shared_context "layout links" do |locale|
  background { visit locale_root_path(locale) }
  given(:home)                { t('layouts.header.home') }
  given(:home_page_title)     { t('layouts.application.base_title') }
  given(:help)                { t('layouts.header.help') }
  given(:help_page_title)     { full_title(t('static_pages.help.help')) }
  given(:about)               { t('layouts.footer.about') }
  given(:about_page_title)    { full_title(t('static_pages.about.about_us')) }
  given(:contact)             { t('layouts.footer.contact') }
  given(:contact_page_title)  { full_title(t('static_pages.contact.contact')) }
  given(:sign_in)             { t('sessions.new.sign_in') }
  given(:sign_in_page_title)  { t('sessions.new.sign_in') }
  given(:sign_in_page)        { signin_path(locale) }
  given(:sign_out)            { t('layouts.account_dropdown.sign_out') }
  given(:users)               { t('layouts.header.users') }
  given(:profile)             { t('layouts.account_dropdown.profile')  }
  given(:settings)            { t('layouts.account_dropdown.settings') }
end

shared_context "signed in layout link destinations" do |locale|
  given(:list_users_page)     { users_path(locale) }
  given(:user_sign_out)       { signout_path(locale) }
  given(:user_profile_page)   { user_path(locale, current_user) }
  given(:user_settings_page)  { edit_user_path(locale, current_user) }
end