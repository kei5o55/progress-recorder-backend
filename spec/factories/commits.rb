# spec/factories/commits.rb
FactoryBot.define do
  factory :commit do
    association :project
    note { "テスト用のコミットメモ" }
    duration_ms { 1500000 }
    started_at { Time.current }
    ended_at { Time.current + 25.minutes }
  end
end