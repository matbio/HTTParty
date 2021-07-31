
require_relative "../models/user_model"

FactoryBot.define do

  factory :user, class: UserModel do
    full_name { "Teste Post User" }
    email { "teste@teste.com" }
    password { "abc123" }

    after(:build) do |user|
      Database.new.delete_user(user.email)
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
end
