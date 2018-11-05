class RemoveUserFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_reference :projects, :user, foreign_key: true
  end
end
