class FeedItemGenerationJob < ApplicationJob
  queue_as :default
  rescue_from "ActiveJob::DeserializationError", with: -> {}

  def perform(user, target, action)
    UserActivityPublisher
      .new(user: user, target: target, action: action)
      .run(delay: false)
  end
end
