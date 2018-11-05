class AddReportDataToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :report_data, :json
  end
end
