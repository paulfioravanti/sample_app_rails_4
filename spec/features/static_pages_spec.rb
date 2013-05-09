require 'spec_helper'

I18n.available_locales.each do |locale|

  feature "Layout links" do
    include_context "layout links", locale: locale

    scenario "Clicking 'Home' link" do
      click_link home
      expect(page).to have_title(home_page_title)
    end

    scenario "Clicking 'Help' link" do
      click_link help
      expect(page).to have_title(help_page_title)
    end

    scenario "Clicking 'About' link" do
      click_link about
      expect(page).to have_title(about_page_title)
    end

    scenario "Clicking 'Contact' link" do
      click_link contact
      expect(page).to have_title(contact_page_title)
    end

  #   # feature "Sign up link" do
  #   #   given(:page_title) { full_title(t('users.new.sign_up')) }
  #   #   given(:sign_up)    { t('static_pages.home_not_signed_in.sign_up') }
  #   #   given(:sign_out)   { t('layouts.header.sign_out') }

  #   #   background { click_link sign_up }

  #   #   it_should_behave_like "a layout link"
  #   # end
  end



  feature "Home page" do
    include_context "home page", locale: locale

    scenario "Viewing the Home page" do
      expect(page).to have_title(base_title)
      expect(page).to_not have_title("| #{home}")
      expect(page).to have_selector('h1', text: header)
    end

  #   # context "for signed-in users" do
  #   #   given(:user) { create(:user) }

  #   #   background do
  #   #     create(:micropost, user: user, content: "Lorem Ipsum")
  #   #     create(:micropost, user: user, content: "Dolor sit amet")
  #   #     visit signin_path(locale)
  #   #     sign_in_through_ui(user)
  #   #     visit locale_root_path(locale)
  #   #   end

  #   #   it "renders the user's feed" do
  #   #     user.feed.each do |item|
  #   #       page.should have_selector("li##{item.id}", text: item.content)
  #   #     end
  #   #   end

  #   #   feature "follower/following counts" do
  #   #     given(:other_user)     { create(:user) }
  #   #     given(:zero_following) { t('shared.stats.following', count: '0') }
  #   #     given(:one_follower)   { t('shared.stats.followers', count: '1') }

  #   #     background do
  #   #       other_user.follow!(user)
  #   #       visit locale_root_path(locale)
  #   #     end

  #   #     specify "user's following section" do
  #   #       should have_link(zero_following,
  #   #                        href: following_user_path(locale, user))
  #   #     end
  #   #     specify "user's follower section" do
  #   #       should have_link(one_follower,
  #   #                        href: followers_user_path(locale, user))
  #   #     end
  #   #   end
  #   # end
  end

  # feature "Help Page" do
  #   given(:heading)    { t('static_pages.help.help') }
  #   given(:page_title) { full_title(t('static_pages.help.help')) }

  #   background { visit help_path(locale) }

  #   it_should_behave_like "a static page"
  # end

  # feature "About Page" do
  #   given(:heading)    { t('static_pages.about.about_us') }
  #   given(:page_title) { full_title(t('static_pages.about.about_us')) }

  #   background { visit about_path(locale) }

  #   it_should_behave_like "a static page"
  # end

  # feature "Contact Page" do
  #   given(:heading)    { t('static_pages.contact.contact') }
  #   given(:page_title) { full_title(t('static_pages.contact.contact')) }

  #   background { visit contact_path(locale) }

  #   it_should_behave_like "a static page"
  # end
end
# end