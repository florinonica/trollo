class Employee < User
  has_and_belongs_to_many :roles, join_table: :employee_roles
  accepts_nested_attributes_for :roles

  def self.model_name
    User.model_name
  end

  def can_see_employees?
  	true
  end

  def is_manager?(id)
    project_workers.find_by(project_id: id).role_id == 1
  end

  def is_dev?(id)
    project_workers.find_by(project_id: id).role_id == 2
  end

  def is_tester?(id)
    project_workers.find_by(project_id: id).role_id == 3
  end

  def can_assign_employees?(id)
    (is_manager?(id) ? true : false)
  end

  def can_see_project_details?
    true
  end

  def can_alter_ticket?(ticket)

    if (id == ticket.owner_id) || (tasks.include?(ticket)) || (is_tester?(ticket.project_id) ) || is_manager?(ticket.project_id)
      return true
    end
    false
  end

  def can_delete_ticket?(ticket)
    ((id == ticket.owner_id) ? true : false)
  end

  def can_add_subtask_or_bug?(ticket)

    if is_tester?(ticket.project_id) || is_manager?(ticket.project_id) || id == ticket.dev_id
      return true
    end

    false
  end

  def can_have_roles?
    true
  end

  def can_edit_comment?(id)
    (self.id == Comment.find(id).user_id ? true : false)
  end

  def can_delete_comment?(id)
    (self.id == Comment.find(id).user_id ? true : false)
  end

  def can_delete_attachment?(attachment)
    (attachments.include?(attachment) ? true : false)
  end

  def can_add_attachment?
    true
  end

  def can_comment?
    true
  end

  def can_see_report?(report)
    (report.owner_id == id ? true : false)
  end

  def can_create_report?(project)
    (is_manager?(project.id) ? true : false)
  end

  def can_see_all_charts?(project)
    (is_manager?(project.id) ? true : false)
  end

end
