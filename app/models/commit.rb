class Commit < ApplicationRecord
  belongs_to :project
  belongs_to :user # ユーザー別管理
  has_one_attached :image # 画像を1枚添付できるように定義

  # 画像のダイレクトURLを取得するためのヘルパーメソッド
  def image_url
    return nil unless image.attached?

    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: false)
  end
end
