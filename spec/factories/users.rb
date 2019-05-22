FactoryBot.define do
  factory :user do
    name { "テストユーザー" }
    email { "test@mail.com" }
    password_digest { "password" }
  end
end
