class CommentsController < ApplicationController
  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = recipe.comments.new(comment_params)
    RecipeCommenting.new(user: current_user, comment_params: comment).run
    redirect_to comment.recipe
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:body)
      .merge(user: current_user)
  end
end
