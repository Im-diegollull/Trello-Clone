class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_state_board, only: [:new, :create]
    before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :is_authorize_user, only: [:new, :create, :edit, :update, :destroy]

    def show
    end

    def new
      @task = @state.tasks.build
    end

    def create
      @task = @state.tasks.build(task_params)
      @task.informer_id = current_user.id 

      if @task.save
        flash[:notice] = "Task created successfully"
        redirect_to board_path(@board)
      else
        flash[:error] = @task.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit
    end

    def update
      if @task.update(task_params)
        flash[:notice] = "Task updated successfully"
        redirect_to board_path(@board)
      else
        flash[:error] = @task.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if @task.destroy
        flash[:notice] = "Task deleted successfully"
      else
        flash[:error] = @task.errors.full_messages.to_sentence
      end
      redirect_to board_path(@board)
    end

    private

    def set_state_board
      @state = State.find_by(id: params[:state_id])
      if @state
        @board = @state.board
      else
        flash[:alert] = "State not found."
        redirect_to boards_path
      end
    end

    def set_task
      @task = Task.find_by(id: params[:id])
      if @task
        @state = @task.state
        @board = @state.board
      else
        flash[:alert] = "Task not found."
        redirect_to boards_path
      end
    end

    # Manage the permits when logged 
    def is_authorize_user
      if @board.creator != current_user && !@board.users.include?(current_user)
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to boards_path
      end
    end

    def task_params
      params.require(:task).permit(:title, :description, :priority, :due_date, :assignee_id, :label_id, :informer_id, :state_id)
    end
end