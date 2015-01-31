class Template < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :codename, presence: true, uniqueness: true, 
    format: { with: /\A[a-zA-Z0-9_-]+\z/, message: "Only letters, numbers, - and _ are allowed" }

  # Default template
  def self.default
    Template.find_by_codename("default") || Template.create({name: "Default", codename: "default"})
  end

  # Load content of the template
  def content
    path = Rails.root.join(ENV["APP.TEMPLATE_DIR"], self.codename)
    head_tpl_file = path.join('resume_head.liquid')
    body_tpl_file = path.join('resume_body.liquid')

    return { head: File.read(head_tpl_file), body: File.read(body_tpl_file) }
  end

end
