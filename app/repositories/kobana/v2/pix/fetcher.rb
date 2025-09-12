module Kobana
  module V2
    module Pix
      class Fetcher < Base
        class << self
          def call(id:)
            response = api.get("charge/pix/#{id}")

            body = JSON.parse(response.body).deep_symbolize_keys

            raise ::Kobana::V2::Base::InvalidRequestError, body[:errors] unless response.success?

            ::Kobana::V2::PixEntity.new(body[:data])
          end
        end
      end
    end
  end
end
