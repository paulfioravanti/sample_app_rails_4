require 'spec_helper'

all_locales_to_all_other_locales do |locale, target_locale|

  feature "Locale switching on pages" do
    include_context "locale switching", locale, target_locale

    scenario "when viewing a page in #{locale}" do
      expect(page).to have_title(current_locale_page_title)
    end

    scenario "when changing language from #{locale} to #{target_locale}" do
      click_link target_language
      expect(page).to have_title target_locale_page_title
      expect(current_locale).to eq(target_locale)
    end
  end

  feature "Locale switching during pagination" do
    include_context "user list for pagination", locale, target_locale

    scenario "when on the users page" do
      click_link next_page
      click_link target_language
      expect(page).to have_active_link '2'
      expect(page.current_url).to match page_two
    end
  end

  feature "Locale switching after a validation error" do
    include_context "locale validation errors", locale, target_locale

    scenario "when failing to create a micropost" do
      sign_in_through_user_interface(user, locale)
      visit home_page
      click_button post_button
      click_link target_language
      expect(page).to have_title home_page_title
    end

    scenario "when failing to update a user" do
      sign_in_through_user_interface(user, locale)
      visit edit_user_page
      click_button save_changes
      click_link target_language
      expect(page).to have_title edit_user_page_title
    end

    scenario "when failing to create an account" do
      visit sign_up_page
      click_button create_account
      click_link target_language
      expect(page).to have_title sign_up_page_title
    end

    scenario "when failing to sign in" do
      visit sign_in_page
      click_button sign_in
      click_link target_language
      expect(page).to have_title sign_in_page_title
    end
  end
end