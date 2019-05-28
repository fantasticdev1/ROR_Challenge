require 'uri'
require 'net/http'

class ZypeController < ApplicationController
  def loadlist

    current_page = 1

    if params[:page]
      current_page = params[:page]
    end

    url = URI(ENV['URI'].to_s + "/videos?app_key=" + ENV['ZYPE_APP_KEY'].to_s + "&per_page=" + ENV['PER_PAGE'].to_s + "&page=" + current_page.to_s)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    data = JSON.parse(http.request(request).read_body)
    
    @videos = data['response']
    @pagination = data['pagination']
    
  end
  
  def show
    if params[:id]
      url = URI(ENV['URI'].to_s + "/videos/" + params[:id].to_s + "?app_key=" + ENV['ZYPE_APP_KEY'].to_s)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url)
      data = JSON.parse(http.request(request).read_body)

      @video = data['response']
    end
  end
end
