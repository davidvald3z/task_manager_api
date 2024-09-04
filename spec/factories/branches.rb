FactoryBot.define do
    factory :branch do
      name { "Default Branch Name" }
      address { "123 Main St" }
      city { "Metropolis" }
      state { "NY" }
      zip_code { "12345" }
    end
  end
  