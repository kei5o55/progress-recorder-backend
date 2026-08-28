class WorkSession < ApplicationRecord
  belongs_to :project
  validates :duration_ms, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  # 2. enum（ステータス・タイマーモードの列挙型定義）
  enum :status, {
    runnning: "running",
    paused: "paused"
  }, default: :paused, validate: true

end
