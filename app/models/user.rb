class User < ApplicationRecord
  has_secure_password

  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authentications, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: /\S+@\S+\.\S+/, message: "Email is invalid" }
  validates :password, length: { in: 6..20 }, presence: true

  enum role: [:user, :admin]

  def self.create_with_auth(auth_hash)
    user = self.create(email: auth_hash["info"]["email"], password: SecureRandom.hex(10))
    Authentication.create(provider: auth_hash["provider"], uid: auth_hash["uid"], user_id: user.id)
    return user
  end
end
