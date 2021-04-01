# frozen_string_literal: true

xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title @rss.title
    xml.description @rss.original_url
    xml.link @rss.generated_url
    if @articles
      @articles.each do |article|
        xml.item do
          xml.title article["title"]
          xml.description article["short_desc"]
          xml.content article["content"]
          xml.pubDate article["published_date"]
          xml.link article["url"]
          xml.guid article["url"]
          xml.image_url article["image_url"]
        end
      end
    else 
      xml.status "Coming soon ..."
    end

  end
end
