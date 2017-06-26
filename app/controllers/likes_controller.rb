class LikesController < ApplicationController
  before_action :require_login

  def create
    RecipeLiking.new(user: current_user, recipe: recipe).run
    redirect_to recipe
  end

  def destroy
    current_user.unlike(recipe)
    redirect_to recipe
  end

  private

  def recipe
    @_recipe ||= Recipe.find(recipe_id)
  end

  def recipe_id
    params[:id]
  end
end
