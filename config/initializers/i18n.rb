I18n::Backend::Simple.include(I18n::Backend::Pluralization)
I18n.available_locales = [:en, :it, :ja]
# I18n.default_locale = :en

# load all config/locales/*.locale.yml
I18n::Tasks.get_locale_data = ->(locale) {
  (Dir["config/locales/**/*.#{locale}.yml"]).inject({}) { |hash, path|
    hash.deep_merge! YAML.load_file(path)
    hash
  }
}