require 'spec_helper'

all_locales do |locale|

  describe "User index" do
    let(:admin) { create(:admin) }
    let(:deleting_a_user) { -> { delete user_path(locale, User.first) } }
    before do
      create_list(:user, 1)
      sign_in!(locale, admin, via_request: true)
    end

    specify "deleting a user as an admin destroys the user" do
      expect(deleting_a_user).to change(User, :count).by(-1)
    end
  end

  describe "Edit user information" do
    let(:user) { create(:user) }

    before { sign_in!(locale, user, via_request: true) }

    context "with forbidden attributes" do
      let(:params) do
        {
          user: {
            admin: true,
            password: user.password,
            password_confirmation: user.password
          }
        }
      end

      before { patch user_path(locale, user), params }

      it "rejects forbidden attributes" do
        expect(user.reload).not_to be_admin
      end
    end
  end
end