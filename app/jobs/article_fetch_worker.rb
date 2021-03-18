# frozen_string_literal: true

class ArticleFetchWorker
  include Sidekiq::Worker
  sidekiq_options queue: :high_priority, retry: 5

  def perform(_article_id)
    logger.info "---ArticleFetchWorker---"
  end
end
