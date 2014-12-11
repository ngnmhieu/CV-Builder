class AddAddress1andAddress2andAddress3ToPersonalDetail < ActiveRecord::Migration
  def change
    add_column :personal_details, :address1, :string
    add_column :personal_details, :address2, :string
    add_column :personal_details, :address3, :string
  end
end
