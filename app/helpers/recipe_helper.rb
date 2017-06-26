module RecipeHelper
  def like_button(recipe)
    if current_user.likes?(recipe)
      link_to "#{fa_icon('heart')} #{recipe.likes_count}".html_safe,
              [:unlike, recipe], class: "button-light icon", method: :post
    else
      link_to "#{fa_icon('heart-o')} #{recipe.likes_count}".html_safe,
              [:like, recipe], class: "button-light icon", method: :post
    end
  end

  def bookmark_button(recipe)
    if current_user.bookmarked?(recipe)
      link_to fa_icon("bookmark").html_safe, [:unbookmark, recipe],
              class: "button-light icon indigo", method: :post
    else
      link_to fa_icon("bookmark-o").html_safe, [:bookmark, recipe],
              class: "button-light icon indigo", method: :post
    end
  end
end
