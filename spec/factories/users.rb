FactoryBot.define do
  factory :user do
    name { 'test_user1' }
    email { 'test_user1@sample.com' }
    password { 'pass1' }
    password_confirmation { 'pass1' }
    # password_digest { 'pass1' }
    admin { 'true' }
    # association :tasks
  end
  factory :second_user, class: User do
    name { 'test_user2' }
    email { 'test_user2@sample.com' }
    password { 'pass2' }
    password_confirmation { 'pass2' }
    # password_digest { 'pass1' }
    admin { 'false' }
    # association :tasks
  end
end
