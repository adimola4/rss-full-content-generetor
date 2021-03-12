# frozen_string_literal: true

class RssUpdater
  def initialize
    @rsses = Rss.all
    end

  def run
    p "Rss Updater..."
    @rsses.each do |rss|
      if rss.id?
        RssFetchWorker.perform_async(rss.id)
      else
        p "not found"
      end
    end
  end
end
