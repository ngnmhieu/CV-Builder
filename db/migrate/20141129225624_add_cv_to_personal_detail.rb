class AddCvToPersonalDetail < ActiveRecord::Migration
  def change
    add_reference :personal_details, :cv, index: true
  end
end
