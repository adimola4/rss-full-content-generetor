# frozen_string_literal: true

class RssFetchWorker
  include Sidekiq::Worker
  sidekiq_options queue: :medium_priority, retry: 3

  def perform(rss_id)
    rss = Rss.find(rss_id)
    puts "RssFetchWorker", rss
    Rss.get_feed(rss)
  end
  end
