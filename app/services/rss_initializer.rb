# frozen_string_literal: true

class RssInitializer
  require_relative("./page_parser")
  def initialize(rss)
    @rss = rss
    @doc = ""
  end

  def run
    p "RssInitializer running..."
    @doc = PageParser.new(@rss.original_url).run

    channel = @doc.search("channel")
    desc = channel.xpath("description").inner_html.to_s.strip
    desc = "0" if desc == ""
    img = channel.search("image").xpath("url").inner_html.to_s.strip
    img = "none" if img == ""
    p channel.search("image").xpath("link").inner_html.to_s.strip

    # TitleGetter.new(channel.xpath('link').inner_html.to_s.strip)
    title = channel.xpath("title").inner_html.to_s.strip
    if title == ""
      title = @rss.original_url
      return nil if img == "none" && desc == "0"
    end

    @rss.attributes = {
      title: title,
      description: desc,
      img_url: img,
    }
    p "RssInitializer finish!!!"
    @rss
  end
end
