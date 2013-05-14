shared_context "home page when signed in" do |locale|
  include_context "sign in a user", locale
  given(:other_user)     { create(:user) }
  given(:zero_following) { "0 #{t('shared.stats.following')}" }
  given(:one_follower)   { "1 #{t('shared.stats.followers')}" }
  given(:user_followers_page) { followers_user_path(locale, user) }
  given(:user_following_page) { following_user_path(locale, user) }
  background do
    create(:micropost, user: user)
    create(:micropost, user: user)
    other_user.follow!(user)
    visit locale_root_path(locale)
  end
end

shared_context "home page when not signed in" do |locale|
  given(:home_page_title)     { t('layouts.application.base_title') }
  given(:with_vertical_bar)   { "| #{t('layouts.header.home')}" }
  given(:home_heading)        { t('layouts.header.sample_app') }
  given(:sign_up)             { t('static_pages.home_not_signed_in.sign_up') }
  given(:sign_up_page_title)  { full_title(t('users.new.sign_up')) }
  background { visit locale_root_path(locale) }
end

shared_context "help page" do |locale|
  given(:help_heading)    { t('static_pages.help.help') }
  given(:help_page_title) { full_title(t('static_pages.help.help')) }
  background { visit help_path(locale) }
end

shared_context "about page" do |locale|
  given(:about_heading)    { t('static_pages.about.about_us') }
  given(:about_page_title) { full_title(t('static_pages.about.about_us')) }
  background { visit about_path(locale) }
end

shared_context "contact page" do |locale|
  given(:contact_heading)    { t('static_pages.contact.contact') }
  given(:contact_page_title) { full_title(t('static_pages.contact.contact')) }
  background { visit contact_path(locale) }
end