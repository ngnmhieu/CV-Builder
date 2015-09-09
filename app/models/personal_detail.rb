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

  def save_attributes(params)
    self.name     = params[:name]
    self.sex      = params[:sex]
    self.email    = params[:email]
    self.website  = params[:website]
    self.address1 = params[:address1]
    self.phone    = params[:phone]
    self.fax      = params[:fax]
    self.address2 = params[:address2]
    self.address3 = params[:address3]
    dob_year      = params['dob(1i)'].to_i
    dob_month     = params['dob(2i)'].to_i
    dob_day       = params['dob(3i)'].to_i
    self.dob      = Date.new(dob_year, dob_month, dob_day)

    self.save
  end
end
