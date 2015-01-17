FactoryGirl.define do
  factory :user do 
    email "test@eat.chocolate"
    association :default_identity, strategy: :build
  end
end
