class ProjectsController < ApplicationController
  before_action :get_project, only: [:show, :edit, :update, :destroy, :files, :dashboard, :reports, :team, :events, :clients, :add_files, :message_board, :add_client, :add_employees, :add_dev, :remove_client, :remove_employee]

  def index
    @projects = current_user.get_projects.paginate(:page => params[:page], per_page:5)
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    params.require(:project).permit(:files => [])
    save_attachments(@project, params[:project][:files])

    if @project.save
      add_event(@project, "Project was created.")
      redirect_to @project
    else
      @project.attachments.each do |file|
        file.destroy
      end
      render 'new'
    end
  end

  def edit
  end

  def update
    params.require(:project).permit(:files => [])
    save_attachments(@project, params[:project][:files])

    if @project.update(project_params)
      redirect_to @project
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def dashboard
  end

  def team
  end

  def clients
  end

  def files
  end

  def events
  end

  def reports
  end

  def message_board
    @project.posts.each do |p|
      p.mark_as_read! for: current_user
    end
  end

  def add_client
    @client = Client.find(params[:project][:client_id])
    @project.clients << @client
    redirect_to clients_path(@project)
  end

  def add_employees

    if params[:project][:role_id] == '1'

      if @project.project_workers.count == 0
        save_pw(params[:id], params[:project][:employee_ids], params[:project][:role_id])
      else
        @projectWorker = @project.project_workers.find_by(role_id: '1')
        @projectWorker.update(:user_id => params[:project][:employee_ids])
        @project.project_workers << @projectWorker
      end

    else
      params[:project][:employee_ids].each do |e|
        save_pw(params[:id], e, params[:project][:role_id])
      end
    end
    redirect_to team_path(@project)
  end

  def add_files
    params.require(:project).permit(:files => [])
    save_attachments(@project, params[:project][:files])
    redirect_to files_path(@project)
  end

  def remove_client
    @client = Client.find(params[:client_id])
    @project.clients = @project.clients - [@client]
    redirect_to clients_path(@project)
  end

  def remove_employee
    @employee = Employee.find(params[:employee_id])
    @project.employees = @project.employees - [@employee]
    redirect_to team_path(@project)
  end

  private
    def project_params
      params.require(:project).permit(:title, :description, :client_id, :attachment_id, :employee,  :role_id, :employee_id, :employee_ids => [])
    end

    def get_project
      @project = Project.find(params[:id])
    end

    def save_pw(id, eid, rid)
      @projectWorker = ProjectWorker.new(project_id: id, user_id: eid, role_id: rid)
      @project.project_workers << @projectWorker
    end

end
