# frozen_string_literal: true

module Api::V1
  class RssController < ApplicationController
    skip_before_action :verify_authenticity_token
    require_relative("../../../services/rss_initializer")

    def index
      @Rss = Rss.all
      render json: @Rss
    end

    def show
      @rss = Rss.find(params[:id])
      render json: @rss
    end

    def create
      if rss_params[:original_url].nil?
        render json: [{ "msg": "Url is required!" }], status: :not_acceptable
        return
      end

      @found_rss = Rss.where(original_url: rss_params[:original_url])

      if @found_rss.empty?
        @rss = Rss.new(rss_params)
        # !!! add generated url in the first user response.
        response = RssInitializer.new(@rss).run
        if response.nil?
          render json: [{ "msg": "The url is not avalid RSS" }], status: :not_acceptable
          return
        end
        if @rss.save
          render json: @rss, status: :created
        else
          render json: [{ "msg": @rss.errors }], status: :unprocessable_entity
        end
      else
        render json: [{ "msg": "exsits rss" }, @found_rss[0]]
        return
      end
    end

    def update
      @rss = Rss.find(params[:id])
      if @rss.update(rss_params)
        render json: @rss
      else
        render json: @rss.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @rss = Rss.find(params[:id])
      @rss.destroy
    end

    def ready
      puts "is ready", params[:rss][:id]
      @rss = Rss.find(params[:rss][:id])
      data = if @rss.generated_url.nil? || @rss.generated_url == "en-us" || @rss.generated_url == "en"
               [{ "msg": "Not ready" }]

             else
               [{ "generated_url": @rss.generated_url }]
             end
      render json: data
      nil
    end

    private

    def rss_params
      params
        .require(:rss)
        .permit(:original_url, :title, :description, :img_url, :generated_url)
    end
  end
  end
