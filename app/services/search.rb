class Search
  def initialize(query:)
    @query = query
  end

  def run
    Recipe.search(query: query)
  end

  private

  attr_reader :query
end
