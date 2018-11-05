class Client < User
  has_and_belongs_to_many :projects, join_table: :clients_projects

  def self.model_name
    User.model_name
  end

  def is_client?(project)
    (projects.include?(project) ? true : false)
  end

  def can_undo?
    false
  end

  def can_see_report?(report)
    (report.available_to_clients == 1 ? true : false)
  end

  def get_unread_project_messages_count
    count = 0
    get_projects.each do |p|
      count += p.posts.select{|post| post.unread?(self)}.count
    end
    count
  end

  def get_unread_project_messages
    messages = []
    get_projects.each do |p|

      if p.posts.select{|post| post.unread?(self)}.any?
        messages.push(p)
      end
    end
    messages
  end

  def get_unread_messages_count
    get_unread_project_messages_count
  end
end
