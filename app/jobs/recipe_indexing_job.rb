class RecipeIndexingJob < ApplicationJob
  queue_as :default

  def perform(recipe)
    RecipeIndexer.new(recipe).run(delay: false)
  end
end
