FactoryBot.define do
    factory :shoe do
        sequence(:model) { |n| "sample model #{n}" }
        store
        alert { false }
        inventory { 0 }
    end
end
