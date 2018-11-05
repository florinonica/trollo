class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  layout "application"
  before_action :authenticate_user!
  respond_to :html, :js

  def save_attachments(container, files)

  	unless files.nil?
  	  files.each do |file|
  	    @attachment = container.attachments.new(user_id: current_user.id, file: file)

  	    if @attachment.save
  	      container.attachments << @attachment
  	    end
  	  end
  	end
  end

  def add_event(project, message)
    @event = project.events.new(message: message)

    if @event.save
      project.events << @event
      sync_new @event, scope: @project
      
    end
  end

end
