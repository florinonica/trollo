class AddCreatorToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :owner, :reference
  end
end
