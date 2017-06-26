module UserHelper
  def follow_button(user)
    if current_user.follows?(user)
      button_to t("unfollow"), [:unfollow, user], class: "button-light"
    else
      button_to t("follow"), [:follow, user], class: "button"
    end
  end

  def user_avatar(user)
    hash = Digest::MD5.hexdigest(user.email)
    image_tag "https://www.gravatar.com/avatar/#{hash}", :alt => user.username, class: "avatar"
  end
end
