shared_context "visiting static home page" do |locale|
  background { visit locale_root_path(locale) }
  given(:home_page_title)     { t('layouts.application.base_title') }
  given(:with_vertical_bar)   { "| #{t('layouts.header.home')}" }
  given(:home_heading)        { t('layouts.header.sample_app') }
  given(:sign_up)             { t('static_pages.home_not_signed_in.sign_up') }
  given(:sign_up_page_title)  { full_title(t('users.new.sign_up')) }
end

shared_context "create a few microposts" do
  background do
    create(:micropost, user: user, content: "Lorem Ipsum")
    create(:micropost, user: user, content: "Dolor sit amet")
  end
end

shared_context "get followed by another user" do |locale|
  given(:other_user)     { create(:user) }
  given(:zero_following) { "0 #{t('shared.stats.following')}" }
  given(:one_follower)   { "1 #{t('shared.stats.followers')}" }
  background do
    other_user.follow!(user)
    visit locale_root_path(locale)
  end
  given(:user_followers_page) { followers_user_path(locale, current_user) }
  given(:user_following_page) { following_user_path(locale, current_user) }
end

shared_context "help page" do |locale|
  background { visit help_path(locale) }
  given(:help_heading)    { t('static_pages.help.help') }
  given(:help_page_title) { full_title(t('static_pages.help.help')) }
end

shared_context "about page" do |locale|
  background { visit about_path(locale) }
  given(:about_heading)    { t('static_pages.about.about_us') }
  given(:about_page_title) { full_title(t('static_pages.about.about_us')) }
end

shared_context "contact page" do |locale|
  background { visit contact_path(locale) }
    given(:contact_heading)    { t('static_pages.contact.contact') }
    given(:contact_page_title) { full_title(t('static_pages.contact.contact')) }
end