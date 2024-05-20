class BoardsController < ApplicationController
    def home
        @boards_recent = Board.order(published_at: :desc).limit(3)
    end

    def index
        @boards = Board.all
    end

    def show
        @board = Board.find_by(id: params[:id])
        if @board
            @states = @board.states.includes(:tasks)
        end 
    end

    def new
		@board = Board.new
	end

	def create  
		@board = Board.new(board_params)
		if @board.save
			flash[:notice] = "board created successfully"
			redirect_to boards_path
		else
			flash[:error] =  @board.errors.full_messages.to_sentence
			redirect_to new_board_path
		end
	end

    def edit
		@board = Board.find(params[:id])
	end

	def update
		@board = Board.find(params[:id])
		if @board.update(board_params)
			flash[:notice] = "board updated successfully"
			redirect_to boards_path
		else
			flash[:error] = @board.errors.full_messages.to_sentence
			redirect_to edit_board_path
		end
	end

    def destroy
        board = Board.find_by(id: params[:id])
        if board.destroy
			flash[:notice] = "board deleted successfully"
		else
			flash[:error] = @board.errors.full_messages.to_sentence
		end
		redirect_to boards_path
    end


    private


    def board_params
		params.require(:board).permit(:name, :creator_id)
	end
end