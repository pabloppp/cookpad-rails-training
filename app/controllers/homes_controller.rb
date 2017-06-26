class HomesController < ApplicationController
  def show
    @recipes = Recipe.latest.page(params[:page])
  end
end
