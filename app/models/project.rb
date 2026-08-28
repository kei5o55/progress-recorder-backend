# app/models/project.rb
class Project < ApplicationRecord
  # belongs_to :user
  has_many :work_sessions, dependent: :destroy
  has_many :commits, dependent: :destroy
  has_many :day_schedules, dependent: :nullify

  validates :name, presence: true # または name

  before_validation :normalize_attributes

  private

  def normalize_attributes
    self.due_date = due_date.presence
    self.memo = memo.presence&.strip

    self.target_hours = nil if target_hours.present? && target_hours <= 0
    self.pomodoro_work_minutes = nil if pomodoro_work_minutes.present? && pomodoro_work_minutes <= 0
    self.pomodoro_break_minutes = nil if pomodoro_break_minutes.present? && pomodoro_break_minutes <= 0
  end
end