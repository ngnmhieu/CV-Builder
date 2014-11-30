class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :institution
      t.string :degree
      t.text :desc
      t.date :start
      t.date :end
      t.references :resume, index: true

      t.timestamps
    end
  end
end
