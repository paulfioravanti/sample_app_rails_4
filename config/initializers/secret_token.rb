# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# if Rails.env.production? && ENV['SECRET_KEY_BASE'].blank?
#   raise 'SECRET_KEY_BASE environment variable must be set!'
# end

# SampleAppRails4::Application.config.secret_key_base =
#   ENV['SECRET_KEY_BASE'] || 'x' * 30

def secure_token
  token_file = Rails.root.join('config/application.yml')
  unless File.exist?(token_file)
    %x(cp config/application.example.yml config/application.yml)
    config = YAML.load_file(token_file)
    token = %x(rake secret)
    config['SECRET_KEY_BASE'] = token
    File.open(token_file, 'w') { |f| YAML.dump(config, f) }
  end
  ENV['SECRET_KEY_BASE']
end

SampleAppRails4::Application.config.secret_key_base = secure_token