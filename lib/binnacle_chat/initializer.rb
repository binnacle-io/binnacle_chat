module BinnacleChat
  module Initializer
		extend ActiveSupport::Concern

    def initialize_binnacle_chat
      gon.apiKey = ENV["BINNACLE_API_KEY"]
      gon.apiSecret = ENV["BINNACLE_API_SECRET"]
      gon.contextId = ENV["BINNACLE_CTX"]
      gon.endPoint = "http://#{ENV["BINNACLE_ENDPOINT"]}:8080"
    end
  end
end
