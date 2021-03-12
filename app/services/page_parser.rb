# frozen_string_literal: true

class PageParser
  require "httparty"

  def initialize(url)
    @url = url
    @type = ""
    @response = ""
    @doc = ""
  end

  def run
    return if @url.nil?

    @response = HTTParty.get(@url)
    # puts @response.body, @response.code, @response.message, @response.headers.inspect
    @type = get_type
    case @type
    when "XML"
      @doc = parse_from_xml
      if @doc.search("channel").empty?
        @doc = parse_from_html
        if @doc.search("channel").empty?

        end
      end
    when "HTML"
      @doc = parse_from_new_url
    when "API"
      @doc = parse_from_api
    else
      puts "Type no match!!!"
    end
    @doc
  end

  def parse_from_xml
    return Nokogiri::XML(@response.to_s)
    s = @url[@url.length - 3, 3]
    if s.to_s.casecmp("xml").zero?
      return Nokogiri::XML(@response.to_s)
    else
      @response = HTTParty.get(@url.to_s + ".xml")
      return Nokogiri::XML(@response.to_s)
      end
  end

  def parse_from_new_url
    Nokogiri::XML(@response.to_s)
  end

  def parse_from_api
    @response = HTTParty.get(@url.to_s)
    Nokogiri::HTML(@response.body)
  end

  def get_type
    s = @url[@url.length - 3, 3]
    if s.to_s.casecmp("xml").zero?
      return "XML"
    else
      @response = HTTParty.get(@url.to_s + ".xml")
      if @response.code.to_s == "200"
        return "HTML"
      else
        return "API"
      end
    end
  end
  end
