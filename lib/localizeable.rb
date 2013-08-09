module Localizeable
  def self.included(base)
    base.send :before_action, :set_locale, :locale_redirect
  end

  private

  def set_locale
    I18n.locale = params[:set_locale] || params[:locale]
  end

  # redirect_action and redirect_controller instance variables exist
  # in case a locale change is made upon an error screen.
  # Rather than redirect back to index, it will now redirect to the
  # appropriate page.
  def locale_redirect
    @redirect_action = redirect_action
    @redirect_controller = redirect_controller
    @page_number = parse_page_number

    if params[:set_locale].present?
      execute_redirect
    end
  end

  def redirect_action
    case action = action_name
      when 'create' then 'new'
      when 'update' then 'edit'
      else action
    end
  end

  def redirect_controller
    controller = controller_name
    if controller == 'microposts' && action_name == 'create'
      @redirect_action = 'home'
      'static_pages'
    else
      controller
    end
  end

  def parse_page_number
    page_number = params[:page]
    if page_number && page_number =~ /^\d+$/
      page_number
    else
      nil
    end
  end

  def execute_redirect
    # only_path: true option used to protect against unwanted
    # redirects from user-supplied values:
    # http://brakemanscanner.org/docs/warning_types/redirect/
    # redirect_to options, only_path: true
    options = { locale: I18n.locale, only_path: true }
    if @redirect_action == 'new'
      if @redirect_controller == 'users'
        redirect_to signup_url, options
      elsif @redirect_controller == 'sessions'
        redirect_to signin_url, options
      end
    else
      default_redirect(options)
    end
  end

  def default_redirect(options)
    options[:controller] = @redirect_controller
    options[:action] = @redirect_action
    options[:page] = @page_number if @page_number
    redirect_to options
  end
end