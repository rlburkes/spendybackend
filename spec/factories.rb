FactoryGirl.define do
  factory :user do
    name     "Randy Burkes"
    email    "randy@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
end