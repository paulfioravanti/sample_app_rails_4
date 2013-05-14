class RelationshipsController < ApplicationController
  before_action :signed_in_user

  respond_to :html, :js

  def create
    @user = User.find(relationship_params[:followed_id])
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end

  private

    def relationship_params
      params.require(:relationship).permit(:followed_id)
    end
end