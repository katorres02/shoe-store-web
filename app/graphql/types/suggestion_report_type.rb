module Types
    class SuggestionReportType < Types::BaseObject
        field :id, String, null: false
        field :low, GraphQL::Types::JSON, null: true
        field :high, GraphQL::Types::JSON, null: true
    end
end
