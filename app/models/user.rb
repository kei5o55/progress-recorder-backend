class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Active Storage で画像を1枚紐付け
  has_one_attached :icon
  # バリデーション
  validates :name, presence: true

  devise :database_authenticatable,#DBに保存されたパスワードでログイン
         :registerable,#ユーザー登録・変更など
         :validatable,#emailやpasswordのバリデーション
         :jwt_authenticatable,
         jwt_revocation_strategy: self
end