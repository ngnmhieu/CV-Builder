class AddTablePersonalDetail < ActiveRecord::Migration
  def change
    create_table :personal_details do |t|
      t.string :name
      t.string :fax
      t.string :phone
      t.string :address
      t.string :picture
      t.string :email
      t.string :website
      t.boolean :sex
      t.string :nationality
      t.date :dob

      t.timestamps
    end

    add_reference :personal_details, :cv, index: true
end
end
