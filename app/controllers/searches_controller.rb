class SearchesController < ApplicationController
  def show
    @query = params[:search][:query]
    @results = Search.new(query: @query).run
  end
end
