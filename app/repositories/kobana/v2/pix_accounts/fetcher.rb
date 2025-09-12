module Kobana
  module V2
    module PixAccounts
      class Fetcher < Base
        class << self
          def call(id:)
            response = api.get("charge/pix_accounts/#{id}")

            body = JSON.parse(response.body).deep_symbolize_keys

            raise ::Kobana::V2::Base::InvalidRequestError, body[:errors] unless response.success?

            ::Kobana::V2::PixAccountEntity.new(body[:data])
          end
        end
      end
    end
  end
end
