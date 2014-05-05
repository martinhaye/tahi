FactoryGirl.define do
  sequence :email do |n|
    "test-user#{n}@example.com"
  end

  sequence :username do |n|
    "test-user#{n}"
  end

  factory :user do
    username
    first_name { ['Zoey', 'Albert', 'Steve'].sample }
    last_name { ['Bob', 'Einstein', 'Windham'].sample }
    email
    password 'password'
    password_confirmation 'password'
    admin false
    trait :admin do
      admin true
    end
  end
end