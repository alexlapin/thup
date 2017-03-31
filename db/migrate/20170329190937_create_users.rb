class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :user_id, null: false # email or first_name[0] + last_name
      t.string :first_name, null: false
      t.string :last_name
      t.integer :employee_number, null: false
      t.timestamps
    end
    add_index :users, :employee_number, unique: true
  end
end
