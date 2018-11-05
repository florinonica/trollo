class RemoveAttachmentFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :attachment, :string
  end
end
