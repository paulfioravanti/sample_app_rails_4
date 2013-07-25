shared_context "micropost creation" do |locale|
  include_context "sign in a user", locale
  given(:translations)         { Micropost.translation_class }
  given(:post)                 { t('static_pages.home.post') }
  given(:clicking_post_button) { -> { click_button post } }
  given(:micropost_content)    { 'micropost_content' }
  given(:new_micropost)        { "Lorem Ipsum Test" }
  given(:locale_count)         { I18n.available_locales.count }
  background                   { visit locale_root_path(locale) }

  def expect_translations_created_for(micropost, current_locale)
    all_locales do |target_locale|
      next if target_locale == current_locale
      click_link t('layouts.locale_selector.language_labels')[target_locale]
      expect(page).to display(new_micropost)
    end
  end
end

shared_context "micropost destruction" do |locale|
  include_context "sign in a user", locale
  given(:delete)               { t('shared.delete_micropost.delete') }
  given(:clicking_delete_link) { -> { click_link delete } }
  given(:translations)         { Micropost.translation_class }
  given(:locale_count)         { I18n.available_locales.count }
  background do
    create(:micropost_with_translations, user: user)
    visit locale_root_path(locale)
  end
end

shared_context "micropost pagination" do |locale|
  include_context "sign in a user", locale
  given(:next_page)                 { t('will_paginate.next_label') }
  given(:first_page_of_microposts) do
    user.microposts.by_descending_date.paginate(page: 1)
  end
  given(:second_page_of_microposts) do
    user.microposts.by_descending_date.paginate(page: 2)
  end
  background do
    create_list(:micropost, 31, user: user)
    visit locale_root_path(locale)
  end
end

shared_context "sidebar" do |locale|
  include_context "sign in a user", locale
  given(:one_micropost_count) { t('shared.user_info.microposts', count: 1) }
  given(:multiple_micropost_count) do
    t('shared.user_info.microposts', count: user.microposts.count)
  end
  given(:zero_micropost_count) { multiple_micropost_count }
  given(:create_a_new_micropost) { create(:micropost, user: user) }
  given(:user_home_page) { locale_root_path(locale) }
  given(:create_multiple_new_microposts) do
    create_list(:micropost, 2, user: user)
  end
  background { visit locale_root_path(locale) }
end

shared_context "feed" do |locale|
  include_context "sign in a user", locale
  given!(:own_micropost) { create(:micropost, user: user) }
  given(:delete_own_micropost) { micropost_path(locale, own_micropost) }
  given(:delete) { t('shared.delete_micropost.delete') }
  given!(:other_user_micropost) { create(:micropost, user: create(:user)) }
  given(:delete_other_user_micropost) do
    micropost_path(locale, other_user_micropost)
  end
  background { visit locale_root_path(locale) }
end