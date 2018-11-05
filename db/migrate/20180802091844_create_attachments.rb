class CreateAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :attachments do |t|
      t.attachment :file
      t.references :user
      t.references :project
      t.references :ticket
      t.references :comment
      t.timestamps
    end
  end
end
