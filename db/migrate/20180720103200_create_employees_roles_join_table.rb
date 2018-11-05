class CreateEmployeesRolesJoinTable < ActiveRecord::Migration[5.2]
  def change
  	create_join_table :employee, :roles do |t|
      t.index :role_id
      t.index :employee_id
    end
  end
end
