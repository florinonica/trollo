class AddContainerToAttachments < ActiveRecord::Migration[5.2]
  def change
  	add_reference :attachments, :container, polymorphic: true, index: true
  end
end
