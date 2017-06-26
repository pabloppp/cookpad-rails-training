class UserActivityPublisher
  def initialize(user:, target:, action:)
    @user = user
    @target = target
    @action = action
  end

  def run(delay: true)
    return if user.followers.none?
    if delay
      create_delayed_job
    else
      publish_activity
    end
  end

  private

  attr_reader :user, :target, :action

  ACTIVITY_MAP = {
    bookmark: BookmarkActivity,
    like: LikeActivity,
    publish_recipe: PublishRecipeActivity,
    comment: CommentActivity
  }.freeze

  private_constant :ACTIVITY_MAP

  def create_delayed_job
    FeedItemGenerationJob.perform_later(user, target, action)
  end

  def publish_activity
    activity = get_activity
    if activity.new_record?
      begin
        activity.save
        publish(activity)
      rescue ActiveRecord::RecordNotUnique
        return
      end
    end
  end

  def get_activity
    activity_class.find_or_initialize_by(
      user: user,
      target: target
    )
  end

  def activity_class
    ACTIVITY_MAP.fetch(action.to_sym)
  end

  def publish(activity)
    user.followers.find_each do |follower|
      FeedItem.create(user: follower, user_activity: activity)
    end
  end
end
