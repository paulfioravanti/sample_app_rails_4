# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
if Rails.env.production? && ENV['SECRET_KEY_BASE'].blank?
  raise 'SECRET_KEY_BASE environment variable must be set!'
end

SampleAppRails4::Application.config.secret_key_base =
  ENV['SECRET_KEY_BASE'] ||
    "81b305de405df746d39accd5090d4691f1b3bba64e3ab41b8b4e129f6bc79bb8a571685a1"\
    "aea7787856c5e2217d48fbbae90bba758e1435ccb1c10b2d79f299b"