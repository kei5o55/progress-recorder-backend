class Project < ApplicationRecord
  has_many :work_sessions, dependent: :destroy
  has_many :commits, dependent: :destroy
  has_many :day_schedules, dependent: :nullify
end