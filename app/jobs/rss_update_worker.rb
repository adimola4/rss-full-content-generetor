# frozen_string_literal: true

class RssUpdateWorker
  include Sidekiq::Worker
  sidekiq_options queue: :medium_priority, retry: 3

  def perform
    logger.info "RssUpdateWorker"
    RssUpdater.new.run
  end
  end
