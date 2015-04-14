FactoryGirl.define do
  factory :user do
    sequence(:email) {|e| "user#{e}@gmail.com" }
    password "hogehoge8"
  end
end
