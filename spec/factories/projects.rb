# spec/factories/projects.rb
FactoryBot.define do
  factory :project do
    name { "テストプロジェクト" }
    completed { false }
  end
end