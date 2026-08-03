class Commit < ApplicationRecord
  belongs_to :project
  has_one_attached :image # ← これを追記
end
