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
      click_link t("layouts.locale_selector.#{target_locale}")
      expect(page).to contain_micropost(new_micropost)
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
  background do
    create_list(:micropost, 31, user: user)
    visit locale_root_path(locale)
  end
  given(:first_page_of_microposts)  { user.microposts.paginate(page: 1) }
  given(:second_page_of_microposts) { user.microposts.paginate(page: 2) }
end