# load all config/locales/*.locale.yml and config/locales/locale.yml:
I18n::Tasks.get_locale_data = ->(locale) {
  (Dir["config/locales/**/*.#{locale}.yml"]).inject({}) { |hash, path|
    hash.deep_merge! YAML.load_file(path)
    hash
  }
}