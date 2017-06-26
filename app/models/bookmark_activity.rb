class BookmarkActivity < UserActivity
  delegate :title, to: :recipe, prefix: true

  def recipe
    target
  end
end
