class AddPolymorphismToAttachments < ActiveRecord::Migration[5.2]
  def change_table
  	add_reference :attachments, :container, polymorphic: true, index: true
  end
end
