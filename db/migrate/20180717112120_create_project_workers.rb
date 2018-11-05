class CreateProjectWorkers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_workers do |t|
      t.references :user
      t.references :project
      t.references :role
      t.timestamps
    end
    add_index :project_workers, [:user_id, :project_id, :role_id], :unique => true
  end
end
