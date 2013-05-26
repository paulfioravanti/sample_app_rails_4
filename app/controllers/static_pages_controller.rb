class StaticPagesController < ApplicationController

  before_action :localized_page, only: [:help, :about, :contact]

  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.eagerly_paginate(params[:page])
    else
      localized_page
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  protected

    def localized_page
      locale = params[:locale]
      @page = "#{Rails.root}/config/locales/#{controller_name}/"\
              "#{action_name}/#{action_name}.#{locale}.md"
    end
end