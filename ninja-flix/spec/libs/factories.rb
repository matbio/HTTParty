require "faker"
require_relative "../models/user_model"

FactoryBot.define do

  factory :user, class: UserModel do
    full_name { "Usuário Válido" }
    email { "user@valid.com" }
    password { "$2b$10$hxF9AGxnfeQBxi2TOGsd0.JqaQ5u180yK4JlldaVW8I0.kBGn1Oli" }

    after(:build) do |user|
      Database.new.delete_user(user.email)
    end
  end

  factory :user_duplicated_email, class: UserModel do
    id {0}
    full_name { Faker::Games::LeagueOfLegends.champion }
    email { Faker::Internet.free_email(name: full_name) }
    password { Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true, special_characters: true) }

    after(:build) do |user|
      Database.new.delete_user(user.email)
      result = ApiUser.user_post(user.to_hash)
      user.id = result.parsed_response["id"]

      #Database.new.insert_user(user.full_name, user.password, user.email)
    end
  end

  factory :user_wrong_email, class: UserModel do
    full_name { "Teste Post User Inválido" }
    email { "t1#teste.com" }
    password { "abc123" }
  end

  factory :user_full_empty, class: UserModel do
    full_name { "" }
    email { "" }
    password { "" }
  end

  factory :user_password_empty, class: UserModel do
    full_name { "Teste Post User Inválido" }
    email { "" }
    password { "" }
  end

  factory :user_email_empty, class: UserModel do
    full_name { "Teste Post User Inválido" }
    email { "" }
    password { "123456" }
  end

  factory :user_full_null, class: UserModel do
    full_name { }
    email { }
    password { }
  end

  factory :user_password_null, class: UserModel do
    full_name { "Teste Post User Inválido" }
    email {  }
    password {  }
  end

  factory :user_email_null, class: UserModel do
    full_name { "Teste Post User Inválido" }
    email {  }
    password { "123456" }
  end

  factory :user_not_found, class: UserModel do
    full_name { Faker::Games::LeagueOfLegends.champion }
    email { Faker::Internet.free_email(name: full_name) }
    password { Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true, special_characters: true) }
    before(:build) do |user|
      Database.new.delete_user(user.email)
    end
  end
end
