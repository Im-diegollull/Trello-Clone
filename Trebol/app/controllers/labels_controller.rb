class LabelsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_board, only: [:index, :show, :new, :create]
    before_action :set_label, only: [:show, :edit, :update, :destroy]
    before_action :is_authorize_user, only: [:new, :create, :edit, :update, :destroy]

    def index
      @labels = @board.labels
    end

    def show
    end

    def new
      @label = @board.labels.build
    end

    def create
      @label = @board.labels.build(label_params)
      if @label.save
        flash[:notice] = "Label created successfully"
        redirect_to board_path(@board)
      else
        flash[:error] = @label.errors.full_messages.to_sentence
        redirect_to :new
      end
    end

    def edit
    end

    def update
      if @label.update(label_params)
        flash[:notice] = "Label updated successfully"
        redirect_to board_path(@board)
      else
        flash[:error] = @label.errors.full_messages.to_sentence
        redirect_to :edit
      end
    end

    def destroy
      if @label.destroy
        flash[:notice] = "Label deleted successfully"
      else
        flash[:error] = @label.errors.full_messages.to_sentence
      end
      redirect_to board_path(@board)
    end

    private

    def set_labels
      @label = Label.find_by(id: params[:id])
      if @label
        @board = @label.board
      else
        flash[:error] = "Label not found."
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

    def label_params
      params.require(:label).permit(:title, :color, :board_id)
    end
end
