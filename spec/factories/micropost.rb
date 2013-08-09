FactoryGirl.define do
  factory :micropost do
    content { Faker::Lorem.sentence(5) }
    user    { create(:user) }

    trait :with_translations do
      after(:create) do |micropost|
        I18n.available_locales.each do |locale|
          next if locale == I18n.locale
          micropost.translations.create(
            locale: locale,
            content: micropost.content
          )
        end
      end
    end
  end
end