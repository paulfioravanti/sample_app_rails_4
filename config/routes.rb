SampleAppRails4::Application.routes.draw do
  scope ":locale", locale: %r(#{I18n.available_locales.join("|")}) do

    get 'help',    to: 'static_pages#help'
    get 'about',   to: 'static_pages#about'
    get 'contact', to: 'static_pages#contact'

    # handles /en|it|ja
    root to: 'static_pages#home', as: "locale_root"
    # handles /en|it|ja/fake-path
    get '*path', to: redirect { |params, request| "/#{params[:locale]}" }
  end

  # handles /
  root to: redirect("/#{I18n.default_locale}")
  # handles /bad-locale|anything/valid-path
  get '/*locale/*path', to: redirect("/#{I18n.default_locale}/%{path}")
  # handles /anything|valid-path-but-no-locale
  get '/*path', to: redirect("/#{I18n.default_locale}/%{path}")
end
