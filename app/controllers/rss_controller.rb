# frozen_string_literal: true

class RssController < ApplicationController
  #     skip_before_action :verify_authenticity_token
  #     def rss
  #         @rss = Source.find(params[:sources_id])
  #         if @source
  #           respond_to do |format|
  #           format.xml { render :layout => false }
  #           end
  #         end
  #     end

  #     private

  #     def rss_params
  #         params
  #             .require(:rss)
  #             .permit(:original_url, :title, :description, :img_url, :generated_url)
  #     end
end
