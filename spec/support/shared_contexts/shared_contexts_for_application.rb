shared_context "sign in a user" do |locale|
  given(:user)     { create(:user) }
  given(:email)    { t('sessions.new.email') }
  given(:password) { t('sessions.new.password') }
  given(:sign_in)  { t('sessions.new.sign_in') }
  background do
    visit signin_path(locale)
    fill_in email, with: user.email
    fill_in password, with: user.password
    click_button sign_in
  end
end