module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :shoes, [Types::ShoeType] ,null: true
    field :suggestions_report, [Types::SuggestionReportType], null: true

    def shoes
      Shoe.order(:model)
    end

    def suggestions_report
      HugeFlashSale::SuggestionsReport.new.generate
    end
  end
end
