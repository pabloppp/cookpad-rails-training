class RecipePublishing
  def initialize(user:, recipe_params:)
    @user = user
    @recipe_params = recipe_params
  end

  def run
    create_recipe.tap do |recipe|
      if recipe.persisted?
        publish_activity(recipe)
      end
    end
  end

  private

  attr_reader :user, :recipe_params

  def create_recipe
    user.recipes.create(recipe_params)
  end

  def publish_activity(recipe)
    UserActivityPublisher.new(
      user: user,
      target: recipe,
      action: "publish_recipe"
    ).run
  end
end
