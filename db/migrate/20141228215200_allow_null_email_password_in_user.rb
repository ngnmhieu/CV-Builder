class AllowNullEmailPasswordInUser < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, null: true
    change_column :users, :password, :string, null: true
  end
end
