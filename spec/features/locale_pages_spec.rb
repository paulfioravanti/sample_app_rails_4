require 'spec_helper'

all_locales_to_all_other_locales do |locale, target_locale|

  feature "Locale switching" do
    include_context "locale switching", locale, target_locale

    scenario "when viewing a page in #{locale}" do
      expect(page).to have_title(current_locale_page_title)
    end

    scenario "when changing language from #{locale} to #{target_locale}" do
      click_link target_language
      expect(page).to have_title(target_locale_page_title)
      expect(current_locale).to eql(target_locale)
    end
  end

  feature "Locale switching during pagination" do
    include_context "sign in a user", locale
    include_context "user list for pagination", locale, target_locale

    scenario "when on the users page" do
      click_link next_page
      click_link target_language
      expect(page).to have_active_link('2')
      expect(page.current_url).to match(page_two)
    end
  end

  feature "Locale switching after a validation error" do
    include_context "locale validation errors", locale, target_locale

    context "for signed in users" do
      include_context "sign in a user", locale
      scenario "when failing to create a micropost" do
        visit locale_root_path(locale)
        click_button post_button
        click_link target_language
        expect(page).to have_title(home_page_title)
      end

      scenario "when failing to update a user" do
        visit edit_user_path(locale, user)
        click_button save_changes
        click_link target_language
        expect(page).to have_title(edit_user_page_title)
      end
    end

    context "for non-signed in users" do
      scenario "when failing to create an account" do
        visit signup_path(locale)
        click_button create_account
        click_link target_language
        expect(page).to have_title(sign_up_page_title)
      end
    end
  end
end