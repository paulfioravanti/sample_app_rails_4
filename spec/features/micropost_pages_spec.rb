require 'spec_helper'

all_locales do |locale|

  feature "Micropost creation" do
    include_context "micropost creation", locale

    scenario "attempting to post with invalid information" do
      click_button post
      expect(page).to have_alert_message 'error'
    end

    scenario "confirming invalid post does not change micropost count" do
      expect(clicking_post_button).to_not change(Micropost, :count)
    end

    scenario "confirming invalid post does not change translations count" do
      expect(clicking_post_button).to_not change(translations, :count)
    end

    scenario "create a new micropost" do
      fill_in micropost_content, with: new_micropost
      click_button post
      expect(page).to display new_micropost
      expect_translations_created_for(new_micropost, locale)
    end

    scenario "confirming new post changes micropost count" do
      fill_in micropost_content, with: new_micropost
      expect(clicking_post_button).to change(Micropost, :count).by(1)
    end

    scenario "confirming new post changes translations count" do
      fill_in micropost_content, with: new_micropost
      expect(clicking_post_button).to \
        change(translations, :count).by locale_count
    end
  end

  feature "Micropost destruction" do
    include_context "micropost destruction", locale

    scenario "confirming deleting micropost destroys it" do
      expect(clicking_delete_link).to change(Micropost, :count).by(-1)
    end

    scenario "confirming deleting micropost destroys its translations" do
      expect(clicking_delete_link).to \
        change(translations, :count).by -locale_count
    end
  end

  feature "Micropost pagination" do
    include_context "micropost pagination", locale

    scenario "viewing the users index page with two pages worth of users" do
      expect(page).to have_section 'pagination'
      expect(page).to have_pagination_link next_page
      expect(page).to have_pagination_link '2'
      expect(page).to_not have_pagination_link '3'
      expect(page).to contain_microposts first_page_of_microposts
      expect(page).to_not contain_microposts second_page_of_microposts
    end

    scenario "viewing the second page of users index" do
      click_link next_page
      expect(page).to_not contain_microposts first_page_of_microposts
      expect(page).to contain_microposts second_page_of_microposts
    end
  end

  feature "Sidebar" do
    include_context "sidebar", locale

    scenario "user has zero microposts" do
      expect(page).to display zero_micropost_count
      expect(page).to_not display one_micropost_count
    end

    scenario "user has one micropost" do
      create_a_new_micropost
      visit user_home_page
      expect(page).to display one_micropost_count
    end

    scenario "user has multiple microposts" do
      create_multiple_new_microposts
      visit user_home_page
      expect(page).to display multiple_micropost_count
      expect(page).to_not display one_micropost_count
    end
  end

  feature "Feed" do
    include_context "feed", locale

    scenario "viewing delete links for own microposts" do
      expect(page).to \
        have_link(delete, href: delete_own_micropost)
    end

    scenario "not being able to view delete links for other's microposts" do
      expect(page).to_not \
        have_link(delete, href: delete_other_user_micropost)
    end
  end
end
