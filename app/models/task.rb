class Task < Ticket
	
  def self.model_name
    Ticket.model_name
  end

  def get_class_colour
  	(task_id.presence ? "#F6E020" : "#28A7F0")
  end

  def get_glyph
    (task_id.presence ? "glyphicon glyphicon-duplicate" : "glyphicon glyphicon-tasks")
  end
end
