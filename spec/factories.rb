FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "12345678" }
    password_confirmation { "12345678" }
  end

  factory :school do
    name { Faker::Team.name}
    description { Faker::Team.sport }
    is_public {[true, false].sample}
  end

end