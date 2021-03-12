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
        data = [{ "msg": "The url is not avalid RSS" }]
        render json: data, status: :not_acceptable
        return
      end
      @found_rss = Rss.where(original_url: rss_params[:original_url])

      

      if @found_rss.empty?
        @rss = Rss.new(rss_params)
        response = RssInitializer.new(@rss).run
        
        if response.nil?

          data = [{ "msg": "The url is not avalid RSS" }]
          render json: data, status: :not_acceptable
          return
         end

        # p @rss.valid?
        # p @rss.errors

        if @rss.save

          render json: @rss, status: :created
        else
          data = [{ "msg": @rss.errors }]
          render json: data, status: :unprocessable_entity
        end
      else
        data = [{ "msg": "exsits rss" }, @found_rss[0]]
        render json: data
        return
      end
    end

    def update
      @rss = Rss.find(params[:id])
      if @rss.update(rss_params)
        render json: @rsss
      else
        render json: @rss.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @rss = Rss.find(params[:id])
      @rss.destroy
    end

    def ready
      # @rss = Rss.where(original_url: rss_params[:original_url])
      # return if @rss.length == 0
      # # data = { "isready": @rss[0].isready }
      # render json: { "isready": @rss[0].isready }
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
    ###############################################################

    private

    def rss_params
      params
        .require(:rss)
        .permit(:original_url, :title, :description, :img_url, :generated_url)
    end
  end
  end
