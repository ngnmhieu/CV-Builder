class CreateMultilineLists < ActiveRecord::Migration
  def change
    create_table :multiline_lists do |t|
      t.string :name
      t.integer :order
      t.references :resume, index: true

      t.timestamps
    end
  end
end
