class My::CommentsController < My::BaseController
  def destroy
    comment = current_user.comments.find(params[:id])
    recipe = comment.recipe
    comment.destroy
    redirect_to recipe
  end
end
