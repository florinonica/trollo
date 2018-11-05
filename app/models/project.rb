class Project < ApplicationRecord
  validates :title, :presence => true, length: { in: 5..50 }
  validates :description, :presence => true, length: { in: 10..200 }
  has_many :tickets, foreign_key: :project_id, dependent: :destroy
  has_many :project_workers, dependent: :destroy
  has_many :employees, through: :project_workers, source: :user
  has_many :roles, through: :project_workers
  has_many :posts, dependent: :destroy
  has_many :attachments, :as => :container, dependent: :destroy
  has_many :events, dependent: :destroy
  has_and_belongs_to_many :clients, join_table: :clients_projects
  has_and_belongs_to_many :reports, join_table: :projects_reports
  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :project_workers
  accepts_nested_attributes_for :posts
  accepts_nested_attributes_for :events


  def get_bugs
  	tickets.where(:type => "Bug")
  end

  def get_tasks_to_do
  	tickets.where(:status => "To do")
  end

  def get_tasks_in_progress
  	tickets.where(:status => "In progress")
  end

  def get_tasks_dev_complete
  	tickets.where(:status => "Dev complete")
  end

  def get_tasks_done
  	tickets.where(:status => "Done")
  end

  def get_progress_percent

    if tickets.count == 0 || tickets.where(:status => "Done").count == 0
      return 0.0
    else
      tickets.where(:status => "Done").count*100.0/tickets.count
    end
  end
end
