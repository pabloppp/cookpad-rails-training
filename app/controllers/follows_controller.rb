class FollowsController < ApplicationController
  before_action :require_login

  def create
    current_user.follow(user_to_follow)
    redirect_to user_to_follow
  end

  def destroy
    current_user.unfollow(user_to_unfollow)
    redirect_to user_to_unfollow
  end

  private

  def user_to_follow
    @_user_to_follow ||= User.find(user_id)
  end

  alias user_to_unfollow user_to_follow

  def user_id
    params[:id]
  end
end
