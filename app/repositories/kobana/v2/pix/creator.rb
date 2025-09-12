module Kobana
  module V2
    module Pix
      class Creator < Base
        class << self
          def call(payload:)
            response = api.post("charge/pix", build_payload(payload))

            body = JSON.parse(response.body).deep_symbolize_keys

            raise ::Kobana::V2::Base::InvalidRequestError, body[:errors] unless response.success?

            ::Kobana::V2::PixEntity.new(body[:data])
          end

          private

          def build_payload(payload)
            {
              amount: payload[:amount],
              payer: {
                document_number: payload[:payer][:document_number],
                name: payload[:payer][:name],
                email: payload[:payer][:email],
                address: {
                  street: "Rua das Flores",
                  zip_code: "12345-678",
                  complement: "Casa 2",
                  number: "123",
                  neighborhood: "Centro",
                  city_name: "São Paulo",
                  state: "SP"
                }
              },
              pix_account_uid: payload[:pix_account_uid],
              txid:,
              expire_at: payload[:expire_at],
              revoke_days: 1,
              message: "string",
              additional_info: {
                Chave: "Valor"
              },
              registration_kind: "instant",
              custom_data: "{\"codigo\": \"123\", \"vip\": true}",
              fine_type: nil,
              fine_amount: "1.00",
              fine_percentage: "5",
              reduction_type: 0,
              reduction_amount: "25.00",
              reduction_percentage: "2.5",
              interest_type: 0,
              interest_amount: "20.00",
              interest_percentage: "2.5",
              tags: nil
            }
          end

          def txid
            Digest::MD5.hexdigest(SecureRandom.uuid)
          end
        end
      end
    end
  end
end
