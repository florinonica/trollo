class PostsController < ApplicationController
  before_action :get_project, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :get_post, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @posts = @project.posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = @project.posts.new(post_params.merge(user_id: current_user.id))
    params.require(:post).permit(:files => [])
    save_attachments(@post, params[:post][:files])

    if @post.save
      sync_new @post, scope: @project
      sync_destroy current_user
      sync_new current_user
      respond_to do |format|
        format.html { redirect_to message_board_path(@project) }
        format.json { render json: @post }
      end
    else
      @post.attachments.each do |file|
        file.destroy
      end
      render 'new'
    end
  end

  private
    def post_params
      params.require(:post).permit(:body, :user_id, :project_id)
    end

    def get_project
      @project = Project.find(params[:project_id])
    end

    def get_post
      @post = Post.find(params[:id])
    end
end
