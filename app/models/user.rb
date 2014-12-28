class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
