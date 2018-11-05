class RemoveColumnsFromAttachments < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :attachments, :project, foreign_key: true
  	remove_reference :attachments, :ticket, foreign_key: true
  	remove_reference :attachments, :comment, foreign_key: true

  end
end
