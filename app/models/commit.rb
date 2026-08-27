# app/models/commit.rb
class Commit < ApplicationRecord
  belongs_to :project
  # いったんユーザ別を無しに
  # belongs_to :user
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

    # only_path: true を機能させるため、ActiveStorage::Current にダミーの host をセット
    ActiveStorage::Current.url_options = { host: "localhost", only_path: true }
    
    # rails_blob_path で相対パスを取得
    Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
  rescue StandardError
    nil
  end
end