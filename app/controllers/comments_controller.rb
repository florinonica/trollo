class CommentsController < ApplicationController
  before_action :get_ticket, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :get_comment, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @comments = @ticket.comments
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @ticket.comments.new(comment_params.merge(user_id: current_user.id))
    params.require(:comment).permit(:files => [])
    save_attachments(@comment, params[:comment][:files])

    if @comment.save
      sync_new @comment, scope: @ticket
      sync_destroy current_user
      sync_new current_user
      respond_to do |format|
        format.html { redirect_to comments_path(@ticket) }
        format.json { render json: @comment }
      end
    else
      @comment.attachments.each do |file|
        file.destroy
      end
      render 'new'
    end
  end

  def edit
  end

  def update
    params.require(:comment).permit(:files => [])
    save_attachments(@comment, params[:comment][:files])
    if @comment.update(comment_params)
      sync_destroy @comment, scope: @ticket
      sync_new @comment, scope: @ticket
      respond_to do |format|
        format.html { redirect_to comments_path(@ticket) }
        format.json { head :no_content }
      end
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    sync_destroy @comment, scope: @ticket
    respond_to do |format|
      format.html { redirect_to comments_path(@ticket) }
      format.json { head :no_content }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body, :user_id, :ticket_id, :parent_id)
    end

    def get_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def get_comment
      @comment = Comment.find(params[:id])
    end
end
