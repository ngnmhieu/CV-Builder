class PersonalDetail < ActiveRecord::Base
  belongs_to :resume
  include HasTemplate
end
