FactoryGirl.define do
  factory :user do 
    name "Test User"
    email "test@paprika.com"
  end

  factory :user_with_resumes, class: User do
    name "Test User"
    email "test@paprika.com"

    after(:create) do |user|
      (1..5).each do |i|
        create(:resume, name: "Resume#{i}",user: user)
      end
    end
  end

  factory :user_default_identity, class: User do
    email "test@paprika.com"

    after(:create) do |user|
      create(:default_identity, user: user)
    end
  end

  factory :user_oauth, class: User do
    email "test@paprika.com"

    after(:create) do |user|
      create(:oauth_identity, user: user)
    end
  end
end
