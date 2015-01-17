FactoryGirl.define do
  factory :default_identity do
    email "test@banana.chilly"
    password "123456789"
    password_confirmation "123456789"
  end
end
