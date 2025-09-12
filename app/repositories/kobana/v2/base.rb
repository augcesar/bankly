module Kobana
  module V2
    class Base
      BASE_URL = ENV.fetch("KOBANA_V2_URL", nil)
      API_KEY = ENV.fetch("KOBANA_V2_KEY", nil)

      InvalidRequestError = Class.new(StandardError)

      def self.api
       Faraday.new(url: BASE_URL) do |faraday|
          faraday.request :url_encoded
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
          faraday.headers["Authorization"] = "Bearer #{API_KEY}"
          faraday.headers["Content-Type"] = "application/json"
          faraday.options.timeout = 10
        end
      end
    end
  end
end
