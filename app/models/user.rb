class User < ApplicationRecord
  # Token生成モジュール
  include TokenGenerateService

  has_secure_password

  validates :name, presence: true, length: { maximum: 30, allow_blank: true }
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
                       length: { minimum: 8, allow_blank: true },
                       format: { with: VALID_PASSWORD_REGEX, allow_blank: true, message: :invalid_password },
                       allow_nil: true

  # リフレッシュトークンのJWT IDを保存
  def remember!(jti)
    update!(refresh_jti: jti)
  end

  # リフレッシュトークンのJWT IDを削除
  def forget!
    update!(refresh_jti: nil)
  end

  def response_json(payload = {})
    as_json(only: [:id, :name]).merge(payload).with_indifferent_access
  end
end
