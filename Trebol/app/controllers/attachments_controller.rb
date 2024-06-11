class AttachmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task_state_board, only: [:new, :create]
    before_action :set_attachment, only: [:show, :edit, :update, :destroy]
    before_action :is_authorize_user, only: [:new, :create, :edit, :update, :destroy]
  
    def show
    end
  
    def new
      @attachment = @task.attachments.build
    end
  
    def create
      @attachment = @task.attachments.build(attachment_params)
  
      if @attachment.save
        flash[:notice] = "Attachment created successfully"
        redirect_to board_path(@board)
      else
        flash[:error] = @attachment.errors.full_messages.to_sentence
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @attachment.update(attachment_params)
        flash[:notice] = "Attachment updated successfully"
        redirect_to board_path(@board)
      else
        flash[:error] = @attachment.errors.full_messages.to_sentence
        render :edit
      end
    end
  
    def destroy
      if @attachment.destroy
        flash[:notice] = "Attachment deleted successfully"
      else
        flash[:error] = @attachment.errors.full_messages.to_sentence
      end
      redirect_to board_path(@board)
    end
  
    private
  
    def set_task_state_board
      @task = Task.find_by(id: params[:task_id])
      if @task
        @state = @task.state
        @board = @state.board
      else
        flash[:error] = "Task not found."
        redirect_to boards_path
      end
    end
  
    def set_attachment
      @attachment = Attachment.find_by(id: params[:id])
      if @attachment
        @task = @attachment.task
        @state = @task.state
        @board = @state.board
      else
        flash[:error] = "Attachment not found."
        redirect_to boards_path
      end
    end
  
    def is_authorize_user
      if @board.creator != current_user && !@board.users.include?(current_user)
        flash[:error] = "Only team members can modify their Boards."
        redirect_to board_path(@board)
      end
    end
  
    def attachment_params
      params.require(:attachment).permit(:task_id, :file_link, :comment)
    end
end
  