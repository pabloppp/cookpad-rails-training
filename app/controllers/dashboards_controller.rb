class DashboardsController < ApplicationController
  before_action :require_login

  def show
    @feed_items = current_user.feed_items
    # @recipes = Recipe.latest.page(params[:page])
  end
end
