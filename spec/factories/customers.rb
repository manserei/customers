FactoryGirl.define do
  factory :customer do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    birthday   { (10000 + rand(5000)).days.ago }

    email      { Faker::Internet.email }
  end
end
