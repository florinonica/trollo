class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :ticket
      t.references :user
      t.references :parent
      t.timestamps
    end
  end
end
