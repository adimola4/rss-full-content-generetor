# frozen_string_literal: true

class ArticleFetchWorker
  include Sidekiq::Worker
  sidekiq_options queue: :high_priority, retry: 10

  def perform(_article_id)
    logger.info "---ArticleFetchWorker---"
    #   article = Article.find(article_id)
    #   logger.info article.title
    #   logger.info article.source_id

    #   article.get_full_html_content
  end
  end
