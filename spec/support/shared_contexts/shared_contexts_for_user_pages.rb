shared_context "signing up" do |locale|
  background { visit signup_path(locale) }
  given(:sign_up_heading)                { t('users.new.sign_up') }
  given(:sign_up_page_title)             { full_title(t('users.new.sign_up')) }
  given(:create_account)                 { t('users.new.create_account') }
  given(:clicking_create_account_button) { -> { click_button create_account } }
  given(:new_user_info)                  { build(:user) }
  given(:welcome)                        { t('flash.welcome') }
  given(:sign_out) { t('layouts.account_dropdown.sign_out') }
  given(:user)     { User.find_by_email("#{new_user_info.email.downcase}") }
end

shared_context "user index" do |locale|
  include_context "sign in a user", locale
  background { visit users_path(locale) }
  given(:users_index_page_title) { full_title(t('users.index.all_users')) }
end

shared_context "user index pagination" do |locale|
  include_context "sign in a user", locale
  background do
    create_list(:user, 30)
    visit users_path(locale)
  end
  given(:next_page)               { t('will_paginate.next_label') }
  given(:first_page_of_users)     { User.paginate(page: 1) }
  given(:second_page_of_users)    { User.paginate(page: 2) }
  given(:users_index_second_page) { users_path(locale, page: 2) }
end

shared_context "delete links" do |locale|
  include_context "sign in a user", locale
  given(:delete_link)     { t('users.user.delete') }
  given(:admin)           { create(:admin) }
  given(:delete_any_user) { user_path(locale, User.first) }
  given(:delete_self)     { user_path(locale, admin) }
  background do
    create_list(:user, 2)
    visit users_path(locale)
  end

  def sign_in_admin(locale)
    visit signin_path(locale)
    sign_in_through_user_interface(admin)
    visit users_path(locale)
  end
end

shared_context "profile page" do |locale|
  include_context "sign in a user", locale
  given!(:first_micropost)     { create(:micropost, user: user) }
  given!(:second_micropost)    { create(:micropost, user: user) }
  given(:profile_page_heading) { user.name }
  given(:profile_page_title)   { full_title(user.name) }
  background                   { visit user_path(locale, user) }
end

shared_context "follow/unfollow users" do |locale|
  include_context "sign in a user", locale
  given(:other_user)               { create(:user) }
  given(:follow)                   { t('users.follow.follow') }
  given(:unfollow)                 { t('users.unfollow.unfollow') }
  given(:clicking_follow_button)   { -> { click_button follow } }
  given(:clicking_unfollow_button) { -> { click_button unfollow } }
  given(:follow_user)              { user.follow!(other_user) }
  given(:user_profile_page)        { user_path(locale, user) }
  given(:other_user_profile_page)  { user_path(locale, other_user) }
  background                       { visit other_user_profile_page }
end

shared_context "following/followers pages" do |locale|
  include_context "sign in a user", locale
  given(:following_page_title)      { t('users.show_follow.following') }
  given(:followers_page_title)      { t('users.show_follow.followers') }
  given(:user_following_page)       { following_user_path(locale, user) }
  given(:other_user_followers_page) { followers_user_path(locale, other_user) }
  given(:user_profile_page)         { user_path(locale, user) }
  given(:other_user)                { create(:user) }
  given(:other_user_profile_page)   { user_path(locale, other_user) }
end

shared_context "user stats" do |locale|
  include_context "sign in a user", locale
  given(:other_user)        { create(:user) }
  given(:user_profile_page) { user_path(locale, user) }
  background do
    user.follow!(other_user)
    other_user.follow!(user)
    visit user_path(locale, user)
  end
end

shared_context "edit user information" do |locale|
  include_context "sign in a user", locale
  given(:save_changes)         { t('users.edit.save_changes') }
  given(:edit_user_heading)    { t('users.edit.update_profile') }
  given(:edit_user_page_title) { full_title(t('users.edit.edit_user')) }
  given(:change)               { t('users.edit.change') }
  given(:sign_out)             { t('layouts.account_dropdown.sign_out') }
  given(:new_name)             { "New Name" }
  given(:new_email)            { "new@example.com" }
  given(:updated_user_info)    { [user, new_name, new_email] }
  given(:updated_user)         { user.reload }
  given(:user_sign_out)        { signout_path(locale) }
  background                   { visit edit_user_path(locale, user) }
end