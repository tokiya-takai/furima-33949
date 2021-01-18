
FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 5)}
    email                 {Faker::Internet.free_email}
    password              {"1A2b3C"}
    password_confirmation {password}
    family_name           {Gimei.last.kanji}
    first_name            {Gimei.first.kanji}
    family_name_kana      {Gimei.last.katakana}
    first_name_kana       {Gimei.first.katakana}
    birthday              {"2000-01-01"}
  end
end
