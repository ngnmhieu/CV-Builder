class Template < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :codename, presence: true, uniqueness: true, 
    format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "Only letters, numbers, - and _ are allowed" }

  def self.default
    Template.find_by_codename("default") || Template.create({name: "Default", codename: "default"})
  end
end
