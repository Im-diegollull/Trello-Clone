class StatesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_board, only: [:new, :create]
    before_action :set_state, only: [:show, :edit, :update, :destroy]
    before_action :is_authorize_user, only: [:new, :create, :edit, :update, :destroy]

    def new
      @state = @board.states.build
    end

    def create
      @state = @board.states.build(state_params)
      if @state.save
        flash[:notice] = "State created successfully"
        redirect_to board_path(@board)
      else
        flash[:error] = @state.errors.full_messages.to_sentence
        render :new
      end
    end

    def edit
    end

    def update
      if @state.update(state_params)
        flash[:notice] = "State updated successfully"
        redirect_to board_path(@board)
      else
        flash[:error] = @state.errors.full_messages.to_sentence
        render :edit
      end
    end

    def destroy
      if @state.destroy
        flash[:notice] = "State deleted successfully"
      else
        flash[:error] = @state.errors.full_messages.to_sentence
      end
      redirect_to board_path(@board)
    end

    private

    def set_state
      @state = State.find_by(id: params[:id])
      if @state
        @board = @state.board
      else
        flash[:error] = "State not found."
        redirect_to boards_path 
      end
    end
  
    def set_board
      @board = Board.find_by(id: params[:board_id])
      if !@board
        flash[:error] = "Board not found."
        redirect_to boards_path
      end
    end

    def is_authorize_user
      if @board.creator != current_user && !@board.users.include?(current_user)
        flash[:error] = "Only team members can modify their Boards."
        redirect_to board_path(@board)
      end
    end

    def state_params
      params.require(:state).permit(:status, :board_position, :board_id)
    end
end