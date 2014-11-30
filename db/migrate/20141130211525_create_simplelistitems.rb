class CreateSimplelistitems < ActiveRecord::Migration
  def change
    create_table :simplelistitems do |t|
      t.string :content
      t.references :simplelist, index: true

      t.timestamps
    end
  end
end
