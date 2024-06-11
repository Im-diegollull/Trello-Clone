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
            @states = @board.states.includes(tasks: :attachments)
        end 
    end

    def new
    	@board = current_user.created_boards.build
	end

    def create
		@board = current_user.created_boards.build(board_params.except(:user_ids))
		@board.creator = current_user
		if @board.save
			user_ids = board_params[:user_ids].reject(&:blank?)
			@board.users = User.where(id: user_ids)
			flash[:notice] = "Board created successfully"
			redirect_to boards_path
		else
			flash[:error] = @board.errors.full_messages.to_sentence
			render :new
		end
	end

    def edit
	end

	def update
        if @board.update(board_params.except(:user_ids))
			@board.users = User.where(id: board_params[:user_ids])
			flash[:notice] = "Board updated successfully"
			redirect_to boards_path
	  	else
			flash[:error] = @board.errors.full_messages.to_sentence
			render :edit
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
			flash[:error] = "Board not found."
			redirect_to boards_path
		end
	end

	def is_authorize_user
		if @board.creator != current_user && !@board.users.include?(current_user)
            flash[:error] = "Only team members can modify their Boards."
			redirect_to boards_path
    	end
	end

    def board_params
	  	params.require(:board).permit(:name, :creator_id, user_ids: [])
	end
end  