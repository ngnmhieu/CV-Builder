FactoryGirl.define do
  factory :user do 
    name "Test User"
    email "test@eat.chocolate"
  end

  factory :user_default_identity, class: User do
    email "test@eat.chocolate"

    after(:create) do |user|
      create(:default_identity, user: user)
    end
  end

  factory :user_oauth, class: User do
    email "test@eat.chocolate"

    after(:create) do |user|
      create(:oauth_identity, user: user)
    end
  end
end
