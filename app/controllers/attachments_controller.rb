class AttachmentsController < ApplicationController

  def destroy
    Attachment.find(params[:id]).destroy
    redirect_to root_path
  end
end
