class Superuser < User

  def self.model_name
    User.model_name
  end

  def can_create_project?
  	true
  end

  def can_edit_project?
  	true
  end

  def can_delete_project?
  	true
  end

  def can_see_all_users?
  	true
  end

  def can_create_user?
  	true
  end

  def can_edit_user?
  	true
  end

  def can_delete_user?
  	true
  end

  def can_add_clients?
    true
  end

  def can_change_manager?
    true
  end

  def can_assign_employees?(id)
    true
  end

  def can_see_project_details?
    true
  end

  def can_see_employees?
    true
  end

  def can_alter_ticket?(ticket)
    true
  end

  def can_delete_ticket?(ticket)
    true
  end

  def is_manager?(id)
    true
  end

  def can_add_subtask_or_bug?(ticket)
    true
  end

  def can_edit_comment?(id)
    (self.id == Comment.find(id).user_id ? true : false)
  end

  def can_delete_comment?(id)
    true
  end

  def can_delete_attachment?(attachment)
    true
  end

  def can_add_attachment?
    true
  end

  def can_comment?
    true
  end

  def can_change_report_availability?
    true
  end

  def can_see_report?(report)
    true
  end

  def can_create_report?(project)
    true
  end

  def can_create_complex_report?
    true
  end

  def can_see_all_charts?(project)
    true
  end

end
