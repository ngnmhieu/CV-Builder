class DefaultIdentity < ActiveRecord::Base
  belongs_to :user

  has_secure_password
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def self.authenticate(email, password)
    identity = DefaultIdentity.find_by(email: email)

    return identity.nil? ? false : identity.authenticate(password)
  end 
end
