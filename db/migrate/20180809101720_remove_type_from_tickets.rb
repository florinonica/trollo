class RemoveTypeFromTickets < ActiveRecord::Migration[5.2]
  def change
    remove_column :tickets, :type, :string
  end
end
