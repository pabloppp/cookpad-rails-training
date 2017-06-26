class CommentActivity < UserActivity
  delegate :body, to: :comment, prefix: true
  delegate :recipe, to: :comment
  delegate :recipe, to: :comment

  def comment
    target
  end

  def recipe_title
    recipe.title
  end
end
