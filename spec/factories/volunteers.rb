FactoryBot.define do
  factory :volunteer do
    title           { Faker::Job.title }
    summary         { Faker::Lorem.sentence }
    location        { Faker::Address.street_name }
    date            { Faker::Time.forward(days: 5,  period: :evening, format: :short) }
    organization_id { nil }
  end
end