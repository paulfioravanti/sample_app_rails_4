require 'spec_helper'

all_locales do |locale|

  describe "Authorization" do
    let(:user) { create(:user) }

    context "for non-signed-in users" do
      it "redirects on PATCH Users#update" do
        patch user_path(locale, user)
        expect(response).to redirect_to(signin_url(locale))
      end

      it "redirects on POST Microposts#create" do
        post microposts_path(locale)
        expect(response).to redirect_to(signin_url(locale))
      end

      it "redirects on DELETE Microposts#destroy" do
        delete micropost_path(locale, create(:micropost))
        expect(response).to redirect_to(signin_url(locale))
      end

      it "redirects on POST Relationships#create" do
        post relationships_path(locale)
        expect(response).to redirect_to(signin_url)
      end

      it "redirects on DELETE Relationships#destroy" do
        delete relationship_path(locale, 1)
        expect(response).to redirect_to(signin_url)
      end
    end

    context "for signed-in users" do
      before { sign_in_via_request(locale, user) }

      it "redirects on GET Users#new" do
        get signup_path(locale)
        expect(response).to redirect_to(locale_root_url(locale))
      end

      it "redirects on POST Users#create" do
        post users_path(locale)
        expect(response).to redirect_to(locale_root_url(locale))
      end
    end

    context "as a wrong user" do
      let(:wrong_user) { create(:user) }
      before { sign_in_via_request(locale, user) }

      it "redirects on PUT Users#update" do
        put user_path(locale, wrong_user)
        expect(response).to redirect_to(locale_root_url(locale))
      end
    end

    context "as a non-admin user" do
      let(:non_admin) { create(:user) }
      before { sign_in_via_request(locale, user) }

      it "redirects on DELETE Users#destroy" do
        delete user_path(locale, user)
        expect(response).to redirect_to(locale_root_url(locale))
      end
    end

    context "as an admin user" do
      let(:admin) { create(:admin) }
      let(:admin_attempting_to_delete_self) do
        -> { delete user_path(locale, admin) }
      end
      let(:no_suicide) { t('flash.no_admin_suicide', name: admin.name) }

      it "prevents admin users from destroying themselves" do
        sign_in_via_request(locale, admin)
        expect(admin_attempting_to_delete_self).to_not change(User, :count)
        expect(response).to redirect_to(users_url(locale))
        expect(flash[:error]).to eq(no_suicide)
      end
    end
  end
end
