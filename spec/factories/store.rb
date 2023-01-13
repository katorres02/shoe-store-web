FactoryBot.define do
    factory :store do
        sequence(:name) { |n| "sample store #{n}" }
    end
end
