class My::RecipesController < My::BaseController
  def new
    @recipe = Recipe.new(ingredients: [Ingredient.new], steps: [Step.new])
  end

  def create
    recipe = RecipePublishing.new(
      user: current_user,
      recipe_params: recipe_params
    ).run
    RecipeIndexer.new(recipe).run
    redirect_to recipe
  end

  def destroy
    recipe = find_recipe
    recipe.destroy
    redirect_to root_path
  end

  def edit
    @recipe = find_recipe
  end

  def update
    recipe = find_recipe
    recipe.update(recipe_params).tap do |success|
      if success
        RecipeIndexer.new(recipe).run
      end
    end
    redirect_to recipe
  end

  private

  def find_recipe
    current_user.recipes.find(params[:id])
  end

  def recipe_params
    params
      .require(:recipe)
      .permit(
        :image,
        :title,
        :description,
        ingredients_attributes: [:id, :name, :_destroy],
        steps_attributes: [:id, :description, :image, :_destroy]
      )
  end
end
