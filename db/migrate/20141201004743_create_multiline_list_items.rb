class CreateMultilineListItems < ActiveRecord::Migration
  def change
    create_table :multiline_list_items do |t|
      t.string :line1
      t.string :line2
      t.text :desc
      t.date :start
      t.date :end
      t.references :multiline_list, index: true

      t.timestamps
    end
  end
end
