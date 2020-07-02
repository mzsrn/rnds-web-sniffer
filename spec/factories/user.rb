FactoryBot.define do
  factory :user do
    email { 'example@mail.com' }
    firstname { 'name' }
    lastname { 'surname' }
    password { '123123213' }
    password_confirmation { password }
  end
end

