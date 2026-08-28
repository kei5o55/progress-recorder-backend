class WorkSession < ApplicationRecord
  belongs_to :project
  validates :duration_ms, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  # 2. enum（ステータス・タイマーモードの列挙型定義）
  enum :status, {
    runnning: "running",
    paused: "paused"
  }, default: :paused, validate: true

  # 3. バリデーション（入力チェック）
  validates :started_at, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :ended_at, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :pomodoro_count, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :pomodoro_work_minutes, numericality: { greater_than: 0 }, allow_nil: true
  validates :pomodoro_break_minutes, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

end
