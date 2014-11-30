class CreateCvs < ActiveRecord::Migration
  def change
    create_table :cvs do |t|
      t.string :name, limit: 255

      t.timestamps
    end
  end
end
