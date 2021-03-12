# frozen_string_literal: true

class RssFetcher
  def initialize(rss)
    puts "RssFetcher------"
    @rss = rss
    @doc = ""
  end

  def run
    @doc = PageParser.new(@rss.original_url).run

    path = ["item link", "item guid", "entry link[rel=alternate]", "entry link"].detect do |tpath|
      @doc.at(tpath)
    end
    return nil unless path

    node = @doc.at(path)
    article_url = (node.inner_html.presence || node["href"]).to_s.strip
    @feed = []
    i = 1
    @doc.css("item").each do |item|
      url = ""
      if item.xpath("guid").to_s["isPermaLink"] == "isPermaLink" || !item.xpath("guid").nil?

        url = item.xpath("guid").inner_html.to_s.strip
        url = item.xpath("link").inner_html.to_s.strip unless url.include?("http")
      else

        url = item.xpath("link").inner_html.to_s.strip
      end
      title = item.xpath("title").inner_html.to_s.strip
      title = get_title_from_url(url) if title == "" && url != ""

      article_data = ArticleFetcher.new(url).run

      @feed << {
        "title" => article_data["title"] || item.xpath("title").inner_html.to_s.strip,
        "short_desc" => article_data["short_desc"] || item.xpath("description").inner_html.to_s.strip,
        "published_date" => item.xpath("pubDate", "published_date", "pubdate").inner_html,
        "content" => article_data["content"] || "coming soon...",
        "image_url" => article_data["image_url"] || "coming soon...",
        "url" => url,
      }
      # TODO :  'tags' => item.xpath('tags').inner_html.to_s.strip,
      # author_name
      # full_html_content
      # image_url
    end
    # puts "feed---", @feed
    @feed
   end

  def get_title_from_url(url)
    @doco = PageParser.new(url).run
    title = ""
    @doco.search("meta").css("meta").each do |item|
      if item.to_s["twitter:title"] == "twitter:title" || item.to_s["og:title"] == "og:title"
        title = item["content"]
      end
    end
    title
  end
  end
