# app/models/commit.rb
class Commit < ApplicationRecord
  belongs_to :project
  belongs_to :user
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

    # 本番環境（S3等）でも安全にURLを取得できるように host を考慮
    Rails.application.routes.url_helpers.rails_blob_url(
      image,
      host: ActiveStorage::Current.url_options[:host] || "localhost:3000"
    )
  end
end