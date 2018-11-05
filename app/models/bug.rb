class Bug < Ticket
	
  def self.model_name
    Ticket.model_name
  end

  def get_class_colour
    "#F66903"
  end

  def get_glyph
  	"glyphicon glyphicon-fire"
  end
end
