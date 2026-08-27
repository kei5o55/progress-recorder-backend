# app/models/commit.rb
class Commit < ApplicationRecord
  belongs_to :project
  #いったんユーザ別を無しに
  #belongs_to :user
  has_one_attached :image

  validates :duration_ms, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  # フロントエンドに返す JSON の構造を整える
  def as_json(options = {})
    super(options.merge(
      methods: [:image_url],
      except: [:created_at, :updated_at]
    ))
  end

  def image_url
    return nil unless image.attached?

    # url_for または rails_blob_path を使い、ホスト依存を安全に処理する
    # hostが取得できない場合は "localhost:3000" を採用
    host = ActiveStorage::Current.url_options&.[](:host) || "localhost:3000"
    
    Rails.application.routes.url_helpers.rails_blob_url(image, host: host)
  rescue StandardError
    nil
  end
end