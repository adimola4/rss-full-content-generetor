# frozen_string_literal: true

class ArticleFetcher
  require "httparty"

  def initialize(article_url)
    @article_url = article_url
    @article_data = {
      "title" => "",
      "short_desc" => "",
      "image_url" => "",
      "content" => "",
    }
  end

  def run
    return if @article_url == ""

    @response = HTTParty.get(@article_url, follow_redirects: false)
    # puts  @response.message, @response.headers.inspect
    @doc = Nokogiri::HTML(@response.to_s)
    clear_doc
    imgs = @doc.search("img")
    imgparents = []
    imgs.each do |img|
      imgparents.push(img.parent)
    end
    @doc.search("img").remove
    @doc.search("picture").remove
    meta = @doc.search("meta").remove
    get_data_from_meta(meta)
    @a_tags = @doc.search("a")
    i = 0
    str = ""

    pass = false
    @doc.xpath("//text()[1]").each do |t|
      next if pass == true

      t.content = t.content.lstrip
      if t.to_s != "" && t.to_s.split.size > 1 && notImage(t.to_s)
        temp_str = t.to_s.tr("\n", "\n").tr("\r", " ").tr("\t", " ").to_s
        next if @article_data["title"] != "" && temp_str.include?(@article_data["title"])
        next if is_site_instructions?(temp_str)
        next if temp_str.end_with?("...")
        next if str.end_with?(temp_str)

        if temp_str.end_with?(".", ". ")
          # p "ddddddd"
          # p temp_str
          # str += " "+t.to_s+t.parent.next.to_s.strip
          str += temp_str + " "
        else # capitalized?(temp_str) == false
          str_hidden = t.parent.next.to_s.strip.gsub(%r{</?[^>]*>}, "")
          str += if str_hidden.strip.end_with?(".")
                   " " + temp_str + " " + str_hidden + " "
                 else
                   if str_hidden.start_with?("\n")
                     " " + temp_str + " "
                   else
                     " " + temp_str + " " + str_hidden + " "
                            end
                 end
            # p temp_str
          end
        #  str += t.to_s.gsub("\n", "\n").gsub("\r", " ").gsub("\t", " ")
        i += 1

      else

        if t.to_s != " " && t.to_s.split.size == 1 && t.parent.next.to_s.strip != ""
          if @article_type == "FOX" || @article_type == "CNN"

            str += " " + t.to_s + t.parent.next.to_s.strip
           end
        end
     end
    end
    @doc.xpath("//text()[last()]").each do |t|
      t.content = t.content.rstrip
    end
    @article_data["content"] = str
    @article_data
    # puts str
    # author_name
    # full_html_content
    # image_url
  end

  def clear_doc
    @doc.search("script").remove
    @doc.search("noscript").remove
    @doc.search("header").remove
    @doc.search("footer").remove
    @doc.search("iframe").remove
    @doc.search("figcaption").remove
    @doc.search("nav").remove
    @doc.search("link").remove
    @doc.search("style").remove
    @doc.search("h1").remove
    @doc.search("h2").remove
    @doc.search("h3").remove
    @doc.search("h4").remove
    @doc.search("h5").remove
    @doc.search("h6").remove
  end

  def get_data_from_meta(meta)
    meta.css("meta").each do |item|
      if @article_data["title"] == "" && (item.to_s["twitter:title"] == "twitter:title" || item.to_s["og:title"] == "og:title")
        @article_data["title"] = item["content"]
      end
      if @article_data["short_desc"] == "" && (item.to_s["twitter:description"] == "twitter:description" || item.to_s["og:description"] == "og:description")
        @article_data["short_desc"] = item["content"]
      end

      unless (@article_data["image_url"] == "" || item["content"].to_s.start_with?("http")) && (item.to_s["twitter:image"] == "twitter:image" || item.to_s["og:image"] == "og:image")
        next
      end
      # if image_exists?(item['content'])
      return if @article_data["image_url"] != ""

      @article_data["image_url"] = item["content"]
      # end
    end
  end

  def image_exists?(url)
    begin
      response = HTTParty.get(url)
    rescue Exception => e
      return nil
    end
    response.headers["content-type"].start_with? "image"
  end

  def notImage(str)
    !(str.include?("image") || str.include?("Image") || str.include?("Photo"))
  end

  def capitalized?(str)
    str.match?(/\A[A-Z]/)
  end

  def in_a_tag?(str)
    @a_tags.each do |a|
      return a.to_s.include?(str)
    end
  end

  def is_site_instructions?(str)
    str = str.to_s.strip.delete("\n")
    common_words = [
      "Advertisement",
      "Subscribed",
      "Subscribe",
      "close",
      "Video",
      "You've successfully subscribed to this newsletter!",
      "Read More",
      "Continue Reading Below",
      "Continue reading the main story",
    ]

    common_words.include?(str)
  end
end
