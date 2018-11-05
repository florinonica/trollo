class Report < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_and_belongs_to_many :users, join_table: :users_reports
  has_and_belongs_to_many :projects
  serialize :report_data, JSON

  def is_available_to_clients?
    ((available_to_clients == true) ? true : false)
  end

  def get_filtered_by_status(status)
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.status == status && t.created_at >= report_data['start_date'].to_s && t.created_at <= report_data['end_date']
      end
    end
    tickets
  end

  def get_filtered_by_created(date)
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.created_at < date
      end
    end
    tickets
  end

  def get_filtered_by_started(date)
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.started_at < date
      end
    end
    tickets
  end

  def get_filtered_by_dev_complete(date)
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.completed_at < date
      end
    end
    tickets
  end

  def get_filtered_by_ended(date)
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.end_at.presence && t.end_at < date
      end
    end
    tickets
  end

  def get_tasks
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t unless t.task_id.presence && t.created_at >= report_data['start_date'] && t.created_at <= report_data['end_date']
      end
    end
    tickets
  end

  def get_subtasks
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.task_id.presence  && !(t.is_a? Bug) && t.created_at >= report_data['start_date'] && t.created_at <= report_data['end_date']
      end
    end
    tickets
  end

  def get_bugs
    tickets = []
    self.projects.each do |project|
      project.tickets.each do |t|
        tickets << t if t.task_id.presence && (t.is_a? Bug) && t.created_at >= report_data['start_date'] && t.created_at <= report_data['end_date']
      end
    end
    tickets
  end

  def get_tickets
    tickets = []
    projects.each do |project|

      if report_data['ticket_status'] == "All" && report_data['ticket_type'] == "All"
        tickets << project.tickets
      elsif report_data['ticket_status'] == "All" && report_data['ticket_type'] != "All"
        tickets << project.tickets.where(type: report_data['ticket_type'])
      elsif report_data['ticket_status'] != "All" && report_data['ticket_type'] == "All"
        tickets << project.tickets.where(status: report_data['ticket_status'])
      else
        tickets << project.tickets.where(status: report_data['ticket_status']).where(type: report_data['ticket_type'])
      end
    end
    tickets
  end

  def get_comments_count
    count = 0
    self.get_tickets.each do |t|
      count += t.comments.count
    end
    count
  end

  def get_average_ticket_solving_time
    count = 0
    sum = 0.0
    get_filtered_by_status("Done").each do |ticket|
      count += 1
      sum += (ticket.end_at - ticket.created_at)
    end
    sum/count/3600
  end

  def get_event_list
    projects.first.events.where(:created_at.to_s >= report_data['start_date'] && :created_at.to_s <= report_data['end_date']).limit(20).order("created_at DESC")
  end

  def get_max_versions_ticket
    max_ticket = projects.first.tickets.first
    projects.first.tickets.each do |t|

      if t.get_versions_count > max_ticket.get_versions_count
        max_ticket = t
      end
    end
    max_ticket
  end

  def get_min_versions_ticket
    min_ticket = projects.first.tickets.first
    projects.first.tickets.each do |t|

      if t.get_versions_count < min_ticket.get_versions_count
        min_ticket = t
      end
    end
    min_ticket
  end

  def is_single_project_report?
    ((projects.count == 1) ? true : false)
  end

end
