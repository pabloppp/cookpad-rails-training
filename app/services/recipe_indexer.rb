class RecipeIndexer
  def initialize(recipe)
    @recipe = recipe
  end

  def run(delay: true)
    if delay
      create_delayed_job
    else
      create_index
    end
  end

  private

  attr_reader :recipe

  def create_delayed_job
    RecipeIndexingJob.perform_later(recipe)
  end

  def create_index
    search_index = SearchIndex.find_or_initialize_by(recipe: recipe)
    search_index.index = recipe_index
    search_index.save
  end

  def recipe_index
    (recipe_values + ingredient_values).join(" ")
  end

  def recipe_values
    [recipe.title]
  end

  def ingredient_values
    recipe.ingredients.map(&:name)
  end
end
