shared_context "layout links" do |locale|
  background { visit locale_root_path(locale) }

  given(:home)               { t('layouts.header.home') }
  given(:home_page_title)    { t('layouts.application.base_title') }
  given(:help)               { t('layouts.header.help') }
  given(:help_page_title)    { full_title(t('static_pages.help.help')) }
  given(:about)              { t('layouts.footer.about') }
  given(:about_page_title)   { full_title(t('static_pages.about.about_us')) }
  given(:contact)            { t('layouts.footer.contact') }
  given(:contact_page_title) { full_title(t('static_pages.contact.contact')) }
end

shared_context "home page" do |locale|
  background { visit locale_root_path(locale) }

  given(:base_title) { t('layouts.application.base_title') }
  given(:home)       { t('layouts.header.home') }
  given(:header)     { t('layouts.header.sample_app') }
end