class User < ActiveRecord::Base
  has_many :resumes, dependent: :destroy

  has_secure_password
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 },
                    format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


  before_create :default_attributes

  def default_attributes
    if self.email
      self.name ||= self.email.split('@')[0].capitalize
    end
  end

end
