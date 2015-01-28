class ChangeUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :email
      t.rename :name, :user_name
    end
  end
end
