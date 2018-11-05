class AddAvailableToClientsToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :available_to_clients, :boolean
  end
end
