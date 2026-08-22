# app/models/day_schedule.rb
class DaySchedule < ApplicationRecord
  belongs_to :user
  belongs_to :project, optional: true # project_id が null でも許可する

  before_validation :clamp_time_values

  validates :date, presence: true
  validates :title, presence: true

  private

  def clamp_time_values
    self.start_hour = (start_hour || 0).clamp(0, 23)
    self.start_minute = (start_minute || 0).clamp(0, 59)
    self.end_hour = (end_hour || 0).clamp(0, 23)
    self.end_minute = (end_minute || 0).clamp(0, 59)
  end
end