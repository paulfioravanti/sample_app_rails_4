require 'spec_helper'

all_locales do |locale|

  feature "Micropost creation" do
    include_context "micropost creation", locale

    scenario "attempting to post with invalid information" do
      click_button post
      expect(page).to have_alert_message('error')
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
      expect(page).to contain_micropost(new_micropost)
      expect_translations_created_for(new_micropost, locale)
    end

    scenario "confirming new post changes micropost count" do
      fill_in micropost_content, with: new_micropost
      expect(clicking_post_button).to change(Micropost, :count).by(1)
    end

    scenario "confirming new post changes translations count" do
      fill_in micropost_content, with: new_micropost
      expect(clicking_post_button).to \
        change(translations, :count).by(locale_count)
    end
  end

  feature "Micropost destruction" do
    include_context "micropost destruction", locale

    scenario "confirming deleting micropost destroys it" do
      expect(clicking_delete_link).to change(Micropost, :count).by(-1)
    end

    scenario "confirming deleting micropost destroys its translations" do
      expect(clicking_delete_link).to \
        change(translations, :count).by(-locale_count)
    end
  end

  feature "Micropost pagination" do
    include_context "micropost pagination", locale

    scenario "viewing the users index page with two pages worth of users" do
      expect(page).to have_section('pagination')
      expect(page).to have_pagination_link(next_page)
      expect(page).to have_pagination_link('2')
      expect(page).to_not have_pagination_link('3')
      expect(page).to contain_microposts(first_page_of_microposts)
      expect(page).to_not contain_microposts(second_page_of_microposts)
    end

    scenario "viewing the second page of users index" do
      click_link next_page
      expect(page).to_not contain_microposts(first_page_of_microposts)
      expect(page).to contain_microposts(second_page_of_microposts)
    end
  end

    # feature "sidebar" do
    #   background do
    #     visit signin_path(locale)
    #     sign_in_through_ui(user)
    #     visit locale_root_path(locale)
    #   end

    #   feature "micropost counts" do
    #     given(:one) { t('shared.user_info.microposts', count: 1) }
    #     given(:other) do
    #       t('shared.user_info.microposts', count: user.microposts.count)
    #     end

    #     context "when user has zero microposts" do
    #       it { should have_selector('span', text: other) }
    #       it { should_not have_selector('span', text: one) }
    #     end

    #     context "when user has one micropost" do
    #       background do
    #         create(:micropost, user: user)
    #         visit locale_root_path(locale)
    #       end

    #       it { should have_selector('span', text: one) }
    #     end

    #     context "when user has multiple microposts" do
    #       background do
    #         create_list(:micropost, 2, user: user)
    #         visit locale_root_path(locale)
    #       end

    #       it { should have_selector('span', text: other) }
    #       it { should_not have_selector('span', text: one) }
    #     end
    #   end
    # end

    # feature "feed" do
    #   let!(:current_user_micropost) do
    #     create(:micropost, user: user)
    #   end

    #   background do
    #     visit signin_path(locale)
    #     sign_in_through_ui(user)
    #     visit locale_root_path(locale)
    #   end

    #   feature "delete links" do
    #     given(:delete) { t('shared.delete_micropost.delete') }
    #     given(:other_micropost) do
    #       create(:micropost, user: create(:user))
    #     end

    #     specify "for user's microposts" do
    #       should have_link(delete, href: micropost_path(locale,
    #                                      current_user_micropost))
    #     end

    #     specify "for other user's microposts" do
    #       should_not have_link(delete, href: micropost_path(locale,
    #                                          other_micropost))
    #     end
    #   end
    # end
end
