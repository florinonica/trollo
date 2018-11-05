class ChangeRolesColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :roles, :name, :role_type
  end
end
