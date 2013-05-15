require 'spec_helper'

all_locales do |locale|

  describe "User index" do
    let(:admin) { create(:admin) }
    let(:deleting_a_user) { -> { delete user_path(locale, User.first) } }
    before do
      create_list(:user, 1)
      sign_in_via_request(locale, admin)
    end

    specify "deleting a user as an admin destroys the user" do
      expect(deleting_a_user).to change(User, :count).by(-1)
    end
  end
end