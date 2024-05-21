class StatesController < ApplicationController
    def new
      @state = State.new(board_id: params[:board_id])
    end
  
    def create
      @state = State.new(state_params)
      if @state.save
        flash[:notice] = "State created successfully"
        redirect_to board_path(@state.board)
      else
        flash[:error] = @state.errors.full_messages.to_sentence
        redirect_to new_sate_path
      end
    end

    def edit
        @state = State.find(params[:id])
      end
      
    def update
        @state = State.find(params[:id])
        if @state.update(state_params)
          flash[:notice] = "state updated successfully"
          redirect_to board_path(@state.board)
        else
          flash[:error] = @state.errors.full_messages.to_sentence
          redirect_to edit_state_path(@state)
        end
    end
  
    private
  
    def state_params
      params.require(:state).permit(:status, :board_position, :board_id)
    end
end
  