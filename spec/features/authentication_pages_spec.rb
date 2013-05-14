require 'spec_helper'

all_locales do |locale|

  feature "Sign in page" do
    include_context "sign in page", locale
    scenario "viewing the sign in page" do
      expect(page).to have_title(sign_in_page_title)
      expect(page).to have_selector('h1', text: sign_in_heading)
    end
  end

  feature "User signin" do
    include_context "user sign in", locale

    context "with invalid credentials" do
      include_context "sign in page", locale
      scenario "unsuccessful sign in attempt" do
        click_button sign_in
        expect(page).to have_title(sign_in_page_title)
        expect(page).to have_alert_message('error', invalid)
      end

      scenario "visiting another page after invalid sign in attempt" do
        click_button sign_in
        click_link home
        expect(page).to_not have_alert_message('error')
      end
    end

    context "with valid credentials" do
      include_context "sign in a user", locale
      scenario "successful sign in" do
        expect(page).to have_title(user.name)
      end

      scenario "signed-in user signing out" do
        click_link sign_out
        expect(page).to have_link(sign_in)
      end
    end
  end

  feature "Authorization" do
    context "for non-signed-in users" do
      include_context "non-signed in authorization", locale

      scenario "visiting the user index page" do
        visit user_index_page
        expect(page).to have_title(sign_in_page_title)
        expect(page).to have_alert_message('notice', sign_in_notice)
      end

      scenario "visiting the user following page" do
        visit user_following_page
        expect(page).to have_title(sign_in_page_title)
        expect(page).to have_alert_message('notice', sign_in_notice)
      end

      scenario "visiting the user followers page" do
        visit user_followers_page
        expect(page).to have_title(sign_in_page_title)
        expect(page).to have_alert_message('notice', sign_in_notice)
      end

      scenario "visiting the user edit page" do
        visit edit_user_page
        expect(page).to have_title(sign_in_page_title)
        expect(page).to have_alert_message('notice', sign_in_notice)
      end

      scenario "visiting a protected page and sign in, out, then in again" do
        visit edit_user_page
        sign_in_through_user_interface(user)
        expect(page).to have_title(edit_user_page_title)
        click_link sign_out
        click_link sign_in
        sign_in_through_user_interface(user)
        expect(page).to have_title(user.name)
      end
    end

    context "for wrong users" do
      include_context "wrong user authorization", locale
      include_context "sign in a user", locale
      scenario "attempting to edit another user's details" do
        visit edit_wrong_user_page
        expect(page).to_not have_title(edit_user_page_title)
      end
    end
  end
end
