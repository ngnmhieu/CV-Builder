class RemoveAddressFromPersonalDetail < ActiveRecord::Migration
  def change
    remove_column :personal_details, :address
  end
end
