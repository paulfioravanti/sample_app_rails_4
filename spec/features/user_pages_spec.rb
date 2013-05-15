require 'spec_helper'

all_locales do |locale|

  feature "Signing up" do
    include_context "signing up", locale

    scenario "viewing the sign up page" do
      expect(page).to have_selector('h1', text: sign_up_heading)
      expect(page).to have_title sign_up_page_title
    end

    scenario "attempting to sign up with invalid information" do
      expect(clicking_create_account_button).to_not change(User, :count)
      expect(page).to have_title sign_up_page_title
      expect(page).to have_alert_message 'error'
      expect(page).to_not have_link sign_out
    end

    scenario "signing up with valid information" do
      fill_in_fields_with new_user_info
      expect(clicking_create_account_button).to change(User, :count)
      expect(page).to have_title user.name
      expect(page).to have_alert_message('success', welcome)
      expect(page).to have_link sign_out
    end
  end

  feature "User index" do
    include_context "user index", locale

    scenario "viewing the users index page with few users" do
      expect(page).to have_title(users_index_page_title)
      expect(page).to_not have_section('pagination')
    end
  end

  feature "Pagination on user index" do
    include_context "user index pagination", locale

    scenario "viewing the users index page with two pages worth of users" do
      expect(page).to have_section('pagination')
      expect(page).to have_pagination_link(next_page)
      expect(page).to have_pagination_link('2')
      expect(page).to_not have_pagination_link('3')
      expect(page).to display_user_profile_links_for(first_page_of_users)
      expect(page).to_not display_user_profile_links_for(second_page_of_users)
    end

    scenario "viewing the second page of users index" do
      click_link next_page
      expect(page).to display_user_profile_links_for(second_page_of_users)
      expect(page).to_not display_user_profile_links_for(first_page_of_users)
    end
  end

  feature "Delete links on user index" do
    include_context "delete links", locale

    scenario "when a regular user" do
      expect(page).to_not have_link(delete_link)
    end

    scenario "when an admin" do
      sign_in_through_user_interface(admin, locale)
      visit users_path(locale)
      expect(page).to have_link(delete_link, href: delete_any_user)
      expect(page).to_not have_link(delete_link, href: delete_self)
    end
  end

  feature "Profile page" do
    include_context "profile page", locale

    scenario "viewing the profile page" do
      expect(page).to have_selector('h1', text: profile_page_heading)
      expect(page).to have_title profile_page_title
    end

    scenario "viewing user microposts on profile page" do
      expect(page).to have_content first_micropost.content
      expect(page).to have_content second_micropost.content
      expect(page).to have_content user.microposts.count
    end
  end

  feature "Follow users" do
    include_context "follow/unfollow users", locale

    scenario "clicking the follow button" do
      click_button follow
      expect(page).to have_button(unfollow)
    end

    scenario "confirming user's followed users" do
      expect(clicking_follow_button).to \
        change(user.followed_users, :count).by(1)
    end

    scenario "confirming other user followers" do
      expect(clicking_follow_button).to \
        change(other_user.followers, :count).by(1)
    end
  end

  feature "Unfollow users" do
    include_context "follow/unfollow users", locale

    background do
      follow_user
      visit other_user_profile_page
    end

    scenario "clicking the unfollow button" do
      click_button unfollow
      expect(page).to have_button(follow)
    end

    scenario "confirming user followed users after unfollowing" do
      expect(clicking_unfollow_button).to change(user.followed_users,
                                                 :count).by(-1)
    end

    scenario "confirming other user followers after unfollowing" do
      expect(clicking_unfollow_button).to change(other_user.followers,
                                                 :count).by(-1)
    end
  end

  feature "Following/Followers pages" do
    include_context "following/followers pages", locale

    background { user.follow!(other_user) }

    scenario "confirming user's followed users page" do
      visit user_following_page
      expect(page).to have_title(following_page_title)
      expect(page).to have_selector('h3', text: following_page_title)
      expect(page).to have_link(other_user.name, href: other_user_profile_page)
    end

    scenario "confirming other user's followers page" do
      visit other_user_followers_page
      expect(page).to have_title(followers_page_title)
      expect(page).to have_selector('h3', text: followers_page_title)
      expect(page).to have_link(user.name, href: user_profile_page)
    end
  end

  feature "User stats" do
    include_context "user stats", locale

    scenario "two users follow each other" do
      expect(page).to have_selector('#following.stat', text: '1')
      expect(page).to have_selector('#followers.stat', text: '1')
    end

    scenario "a user unfollows another user" do
      user.unfollow!(other_user)
      visit user_profile_page
      expect(page).to have_selector('#following.stat', text: '0')
    end

    scenario "a user gets unfollowed by another user" do
      other_user.unfollow!(user)
      visit user_profile_page
      expect(page).to have_selector('#followers.stat', text: '0')
    end
  end

  feature "Edit user information" do
    include_context "edit user information", locale
    scenario "viewing the edit user page" do
      expect(page).to have_selector('h1', text: edit_user_heading)
      expect(page).to have_title(edit_user_page_title)
    end

    scenario "attempting to update details with invalid information" do
      click_button save_changes
      expect(page).to have_alert_message('error')
    end

    scenario "updating details with valid information" do
      fill_in_fields_with *updated_user_info
      click_button save_changes
      expect(page).to have_title(new_name)
      expect(page).to have_alert_message('success')
      expect(page).to have_link(sign_out, href: user_sign_out)
      expect(updated_user.name).to eql(new_name)
      expect(updated_user.email).to eql(new_email)
    end
  end
end