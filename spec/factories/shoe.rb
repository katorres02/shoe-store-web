FactoryBot.define do
    factory :shoe do
        model { "sample model" }
        store
        alert { false }
        inventory { 0 }
    end
end
