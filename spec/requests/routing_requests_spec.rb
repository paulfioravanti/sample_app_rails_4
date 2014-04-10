require 'spec_helper'

describe "Routing Requests" do

  context "locale scoped paths" do
    all_locales do |locale|
      it "redirects fake paths to the home page" do
        get "/#{locale.to_s}/fake_path"
        expect(response).to redirect_to(locale_root_url(locale))
      end
    end
  end

  context "non-locale scoped paths" do
    let(:valid_action) { "about" }
    let!(:default_locale_action_url) { about_url(I18n.default_locale) }
    let(:unsupported_locale) { "fr" }

    it "redirects no path to default locale home page" do
      get "/"
      expect(response).to redirect_to(locale_root_url(I18n.default_locale))
    end

    it "redirects unsupported locales to requested page in default locale" do
      get "/#{unsupported_locale}/#{valid_action}"
      expect(response).to redirect_to(default_locale_action_url)
    end

    it "redirects invalid locales to requested page in default locale" do
      get "/invalid_locale/#{valid_action}"
      expect(response).to redirect_to(default_locale_action_url)
    end

    it "redirects no locale to requested page in default locale" do
      get "/#{valid_action}"
      expect(response).to redirect_to(default_locale_action_url)
    end

    # Currently failing with Rails 4
    # See https://github.com/rspec/rspec-rails/issues/916
    # it "redirects unrecognized paths to default locale equivalent" do
    #   get "/invalid_info"
    #   expect(response).to redirect_to("/#{I18n.default_locale}/invalid_info")
    #   # This will then get caught by the "redirecting fake paths" condition
    #   # and hence be redirected to locale_root_url with I18n.default_locale
    # end
  end
end