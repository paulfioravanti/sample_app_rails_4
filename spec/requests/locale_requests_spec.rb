require 'spec_helper'

# Any controller that uses strong parameters will stop a
# request before it gets to the model. Therefore, most tests
# for locale switching that were here for Rails 3 can't get through
# to the model to fail validation and render a response.
# Hence, they have been removed.
all_locales_to_all_other_locales do |locale, target_locale|
  describe "Locale switching for non-signed in users" do
    specify "locale switch on #{locale} sign in fail redirects"\
      "to #{target_locale} sign in page" do
      post session_path(locale)
      get signin_path(set_locale: target_locale)
      expect(response).to redirect_to(signin_url(target_locale))
    end
  end
end
