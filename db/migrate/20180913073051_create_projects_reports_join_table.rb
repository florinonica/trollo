class CreateProjectsReportsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :projects, :reports do |t|
      t.index :project_id
      t.index :report_id
    end
  end
end
