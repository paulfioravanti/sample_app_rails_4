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
#== Route Map
# Generated on 08 May 2013 18:45
#
#        help GET /:locale/help(.:format)    static_pages#help {:locale=>/en|it|ja/}
#       about GET /:locale/about(.:format)   static_pages#about {:locale=>/en|it|ja/}
#     contact GET /:locale/contact(.:format) static_pages#contact {:locale=>/en|it|ja/}
# locale_root GET /:locale(.:format)         static_pages#home {:locale=>/en|it|ja/}
#             GET /:locale/*path(.:format)   redirect(301) {:locale=>/en|it|ja/}
#        root GET /                          redirect(301, /en)
#             GET /*locale/*path(.:format)   redirect(301, /en/%{path})
#             GET /*path(.:format)           redirect(301, /en/%{path})
