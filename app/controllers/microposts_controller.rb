class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  respond_to :html, :json

  def create
    # @micropost = current_user.microposts.build(micropost_params)
    @micropost = Micropost.new(micropost_params)
    if @micropost.save
      create_translations
      flash[:success] = t('flash.micropost_created')
      redirect_to locale_root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to locale_root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content).merge(user: current_user)
    end

    # Put the same content in all locale translations
    def create_translations
      I18n.available_locales.each do |locale|
        next if locale == I18n.locale
        @micropost.translations.create(locale: locale,
                                       content: micropost_params[:content])
      end
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to locale_root_url if @micropost.nil?
    end
end