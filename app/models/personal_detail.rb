class PersonalDetail < ActiveRecord::Base
  belongs_to :resume
  include HasTemplate

  liquid_methods :template, :name, :website, :email, :phone, :fax, :address1, :address2, :address3, :dob

  after_initialize :default_attributes

  def default_attributes
    self.name ||= self.website ||= self.email ||= self.phone ||= self.fax ||= ""
    self.address1 ||= self.address2 ||= self.address3 ||= ""
    self.dob = Time.now
  end
end
