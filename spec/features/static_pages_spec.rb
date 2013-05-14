require 'spec_helper'

all_locales do |locale|

  feature "Home page when signed in" do
    include_context "home page when signed in", locale

    scenario "viewing the user feed" do
      expect(page).to have_unique_css_ids_in(user.feed)
    end

    scenario "viewing the follower counts" do
      expect(page).to have_link(one_follower, href: user_followers_page)
    end

    scenario "viewing the following counts" do
      expect(page).to have_link(zero_following, href: user_following_page)
    end
  end

  feature "Home page when not signed in" do
    include_context "home page when not signed in", locale

    scenario "Visiting the Home page" do
      expect(page).to have_title home_page_title
      expect(page).to_not have_title with_vertical_bar
      expect(page).to have_selector('h1', text: home_heading)
      expect(page).to have_link sign_up
    end

    scenario "clicking 'Sign up' link" do
      click_link sign_up
      expect(page).to have_title sign_up_page_title
    end
  end

  feature "Help page" do
    include_context "help page", locale
    scenario "Viewing the Help page" do
      expect(page).to have_title help_page_title
      expect(page).to have_selector('h1', text: help_heading)
    end
  end

  feature "About page" do
    include_context "about page", locale
    scenario "Viewing the About page" do
      expect(page).to have_title about_page_title
      expect(page).to have_selector('h1', text: about_heading)
    end
  end

  feature "Contact page" do
    include_context "contact page", locale
    scenario "Viewing the Contact page" do
      expect(page).to have_title contact_page_title
      expect(page).to have_selector('h1', text: contact_heading)
    end
  end
end