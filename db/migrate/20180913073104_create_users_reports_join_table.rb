class CreateUsersReportsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :reports do |t|
      t.index :user_id
      t.index :report_id
    end
  end
end
