class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.string :attachment
      t.references :project
      t.references :owner
      t.references :dev
      t.references :task
      t.string :status
      t.string :priority
      t.datetime :created_at
      t.datetime :completed_at
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
end
