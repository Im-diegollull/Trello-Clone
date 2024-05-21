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
          flash[:notice] = "State updated successfully"
          redirect_to board_path(@state.board)
        else
          flash[:error] = @state.errors.full_messages.to_sentence
          redirect_to edit_state_path(@state)
        end
    end
  
    def destroy
        state = State.find_by(id: params[:id])
        if state.destroy
            flash[:notice] = "State deleted successfully"
        else
            flash[:error] = @state.errors.full_messages.to_sentence
        end
        redirect_to  board_path(state.board)
    end


    private
  
    def state_params
      params.require(:state).permit(:status, :board_position, :board_id)
    end
end
  