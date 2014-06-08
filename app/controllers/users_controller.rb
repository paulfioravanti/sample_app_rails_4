class UsersController < ApplicationController

  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :following,
                       :followers]
  before_action :signed_in_users, only: [:new, :create]
  before_action :find_user,
                only: [:show, :edit, :update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,   only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @microposts =
      @user.microposts.by_descending_date.includes(:translations).paginate(page: page_param)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      flash[:success] = t('flash.welcome')
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      sign_in(@user)
      flash[:success] = t('flash.profile_updated')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if !current_user?(user)
      user.destroy
      flash[:success] = t('flash.user_destroyed')
    else
      flash[:error] = t('flash.no_admin_suicide', name: user.name)
    end
    redirect_to users_url
  end

  def following
    @users = @user.followed_users.paginate(page: params[:page])
    show_follow
  end

  def followers
    @users = @user.followers.paginate(page: params[:page])
    show_follow
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # This is of dubious merit as it's just hiding assignment
    # from Brakeman, but it does silence dynamic path render issues
    def page_param
      params[:page]
    end

    def show_follow
      calling_method = caller[0][/`(.*)'/, 1]
      @title = t("users.show_follow.#{calling_method}")
      render 'show_follow'
    end

    def correct_user
      redirect_to locale_root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to locale_root_url unless current_user.admin?
    end

    def signed_in_users
      redirect_to locale_root_url if signed_in?
    end

end
