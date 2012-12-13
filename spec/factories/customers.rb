FactoryGirl.define do
  factory :customer do
    first_name "Manfred"
    last_name "Mustermann"

    sequence(:email) { |n| "manfred-#{n}@mustermann.de" }
  end
end
