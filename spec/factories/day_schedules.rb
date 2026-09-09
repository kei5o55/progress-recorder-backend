# spec/factories/day_schedules.rb
FactoryBot.define do
  factory :day_schedule do
    # 日付の重複を防ぐため sequence を活用するのが優雅です
    sequence(:target_date) { |n| Date.current + n.days }
    notes { "テストコメント" }
  end
end