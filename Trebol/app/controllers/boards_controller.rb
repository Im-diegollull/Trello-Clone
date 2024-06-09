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
			# Needed to add user to board through user board to manage teams 
			add_user_to_board(@board, board_params[:user_id])
			flash[:notice] = "Board created successfully"
			redirect_to boards_path
		else
			flash[:error] =  @board.errors.full_messages.to_sentence
			render :new
		end
	end

    def edit
	end

	def update
		# Needed to add user to board through user board to manage teams when updating a board
		user_id = board_params[:user_id]
		if @board.update(board_params.except(:user_id)) # This helped on some errors dunno
			add_user_to_board(@board, user_id)
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

	# Needed to add user to board through user board to manage teams
	# some how we need to add more user to the board, through the form, to create more teams
	def add_user_to_board(board, user_id)
		user = User.find_by(id: user_id)
		if user && !board.users.include?(user)
		  board.users << user
		end
	end  

	def set_board
		@board = Board.find_by(id: params[:id])
		if !@board
		  flash[:error] = "Board not found."
		  redirect_to boards_path
		end
	end

	# Manage the permits when logged 
	def is_authorize_user
		if @board.creator != current_user && !@board.users.include?(current_user)
		  flash[:error] = "Only team members can modify their Boards."
		  redirect_to boards_path
		end
	end

    def board_params
		params.require(:board).permit(:name, :user_id) # some how manage to accepts more users
	end
end