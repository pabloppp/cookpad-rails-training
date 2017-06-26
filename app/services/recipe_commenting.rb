class RecipeCommenting
  def initialize(user:, comment_params:)
    @user = user
    @comment_params = comment_params
  end

  def run
    create_comment.tap do |comment|
      if comment.persisted?
        publish_activity(comment)
      end
    end
  end

  private

  attr_reader :user, :comment_params

  def create_comment
    recipe.comments.create(comment_params)
  end

  def publish_activity(comment)
    UserActivityPublisher.new(
      user: user,
      target: comment,
      action: "comment"
    ).run
  end
end
