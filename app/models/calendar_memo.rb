# app/models/calendar_memo.rb
class CalendarMemo < ApplicationRecord
  belongs_to :user

  validates :date, presence: true
  validates :text, presence: true
end