require 'spec_helper'

all_locales do |locale|

  describe "micropost destruction" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:other_micropost) { create(:micropost, user: other_user) }
    let(:deleting_other_micropost) do
      -> { delete micropost_path(locale, other_micropost) }
    end
    let(:translations) { Micropost.translation_class }

    before { sign_in_via_request(locale, user) }

    it "redirects on DELETE Micropost#destroy if not own micropost" do
      delete micropost_path(locale, other_micropost)
      expect(response).to redirect_to(locale_root_url)
      expect(deleting_other_micropost).to_not change(Micropost, :count)
      expect(deleting_other_micropost).to_not change(translations, :count)
    end
  end
end