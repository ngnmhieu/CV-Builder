class PersonalDetail < ActiveRecord::Base
  belongs_to :resume
  include HasTemplate

  after_initialize :default_attributes

  def default_attributes
    self.name ||= self.website ||= self.email ||= self.phone ||= self.fax ||= ""
    self.address1 ||= self.address2 ||= self.address3 ||= ""
    self.dob = Time.now
  end
end
