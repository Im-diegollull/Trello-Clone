class BoardsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show, :home]
	before_action :set_board, only: [:show, :edit, :update, :destroy]
	before_action :is_authorize_user, only: [:edit, :update, :destroy]

    def home
        @boards_recent = Board.order(published_at: :desc).limit(3)
    end

    def index
        @boards = Board.all
    end

    def show
        if @board
            @states = @board.states.includes(:tasks)
        end 
    end

    def new
		@board = current_user.created_boards.build
	end

	def create  
		@board = current_user.created_boards.build(board_params)
		@board.creator = current_user
		if @board.save
			flash[:notice] = "Board created successfully"
			redirect_to boards_path
		else
			flash[:error] =  @board.errors.full_messages.to_sentence
			redirect_to new_board_path
		end
	end

    def edit
	end

	def update
		if @board.update(board_params)
			flash[:notice] = "Board updated successfully"
			redirect_to boards_path
		else
			flash[:error] = @board.errors.full_messages.to_sentence
			redirect_to edit_board_path
		end
	end

    def destroy
        if @board.destroy
			flash[:notice] = "Board deleted successfully"
		else
			flash[:error] = @board.errors.full_messages.to_sentence
		end
		redirect_to boards_path
    end


    private

	def set_board
		@board = Board.find_by(id: params[:id])
		if !@board
		  flash[:alert] = "Board not found."
		  redirect_to boards_path
		end
	end

	def is_authorize_user
		if @board.creator != current_user && !@board.users.include?(current_user)
		  flash[:alert] = "You are not authorized to perform this action."
		  redirect_to boards_path
		end
	end

    def board_params
		params.require(:board).permit(:name)
	end
end