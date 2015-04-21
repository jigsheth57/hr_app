class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.date :hiredate
      t.float :salary
      t.boolean :fulltime
      t.integer :vacationdays
      t.text :comments

      t.timestamps null: false
    end
  end
end
