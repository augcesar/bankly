module Kobana
  module V2
    class PixAccountEntity < BaseEntity
      attribute :id, Types::Nominal::Integer
      attribute :uid, Types::Nominal::String
      attribute :custom_name, Types::Nominal::String
      attribute :enabled_at, Types::Nominal::DateTime
      attribute :financial_provider_slug, Types::Nominal::String
      attribute :key, Types::Nominal::String
      attribute :status, Types::Nominal::String
      attribute :default, Types::Bool
      attribute :created_at, Types::Nominal::DateTime
      attribute :updated_at, Types::Nominal::DateTime
    end
  end
end
