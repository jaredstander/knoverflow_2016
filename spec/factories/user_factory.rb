FactoryGirl.define do

  factory :user do
    name "Artorias"
    email "artorias@abysswalker.net"
    password "eightcharacterslong"
    password_confirmation "eightcharacterslong"

    factory :user_with_question do
      after(:create) do |user|
        create(:question, user: user)
      end
    end
  end

end