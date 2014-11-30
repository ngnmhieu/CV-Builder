class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :company
      t.string :position
      t.text :desc
      t.date :start
      t.date :end
      t.references :resume, index: true

      t.timestamps
    end
  end
end
