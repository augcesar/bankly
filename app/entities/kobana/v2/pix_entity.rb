module Kobana
  module V2
    class PixEntity < BaseEntity
      attribute :id, Types::Nominal::Integer
      attribute :uid, Types::Nominal::String
      attribute :txid, Types::Nominal::String
      attribute :status, Types::Nominal::String
      attribute :registration_status, Types::Nominal::String
      attribute :pix_account_id, Types::Nominal::Integer
      attribute :pix_account_uid, Types::Nominal::String
      attribute :kind, Types::Nominal::String
      attribute :created_at, Types::Nominal::String
      attribute :updated_at, Types::Nominal::String
      attribute :expire_at, Types::Nominal::DateTime.optional
      attribute :canceled_at, Types::Nominal::DateTime.optional
      attribute :registered_at, Types::Nominal::DateTime
      attribute :amount, Types::Nominal::Float
    end
  end
end
