require 'spec_helper'

all_locales do |locale|

  feature "Layout links" do
    include_context "layout links", locale

    scenario "clicking 'Home' link" do
      click_link home
      expect(page).to have_title home_page_title
    end

    scenario "clicking 'Help' link" do
      click_link help
      expect(page).to have_title help_page_title
    end

    scenario "clicking 'About' link" do
      click_link about
      expect(page).to have_title about_page_title
    end

    scenario "clicking 'Contact' link" do
      click_link contact
      expect(page).to have_title contact_page_title
    end

    scenario "confirming visible links" do
      expect(page).to have_link(sign_in, href: sign_in_page)
      expect(page).to_not have_link sign_out
      expect(page).to_not have_link users
      expect(page).to_not have_link profile
      expect(page).to_not have_link settings
    end

    scenario "confirming visible links" do
      sign_in!(locale, user)
      expect(page).to_not have_link sign_in
      expect(page).to have_link(sign_out, href: user_sign_out)
      expect(page).to have_link(users, href: list_users_page)
      expect(page).to have_link(profile, href: user_profile_page)
      expect(page).to have_link(settings, href: user_settings_page)
    end
  end
end