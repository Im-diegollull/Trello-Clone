class TasksController < ApplicationController
    def new
      @task = Task.new(state_id: params[:state_id])
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        flash[:notice] = "Task created successfully"
        redirect_to board_path(@task.state.board)
      else
        flash[:error] = @task.errors.full_messages.to_sentence
        redirect_to new_board_state_task_path(@task.state.board, @task.state)
      end
    end
  
    def edit
      @task = Task.find(params[:id])
    end
  
    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        flash[:notice] = "Task updated successfully"
        redirect_to board_path(@task.state.board)
      else
        flash[:error] = @task.errors.full_messages.to_sentence
        redirect_to edit_board_state_task_path(@task.state.board, @task.state, @task)
      end
    end
  
    def destroy
      task = Task.find_by(id: params[:id])
      if task.destroy
        flash[:notice] = "Task deleted successfully"
      else
        flash[:error] = task.errors.full_messages.to_sentence
      end
      redirect_to board_path(task.state.board)
    end
  
    private
  
    def task_params
      params.require(:task).permit(:title, :description, :priority, :due_date, :assignee_id, :label_id, :informer_id, :state_id)
    end
  end
  