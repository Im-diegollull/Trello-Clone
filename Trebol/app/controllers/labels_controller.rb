class LabelsController < ApplicationController
    def index
      @board = Board.find(params[:board_id])
      @labels = @board.labels
    end

    def show
      @label = Label.find(params[:id])
    end

    def new
      @label = Label.new(board_id: params[:board_id])
    end

    def create
      @label = Label.new(label_params)
      if @label.save
        flash[:notice] = "Label created successfully"
        redirect_to board_path(@label.board)
      else
        flash[:error] = @label.errors.full_messages.to_sentence
        redirect_to new_board_label_path(@label.board)
      end
    end

    def edit
      @label = Label.find(params[:id])
    end

    def update
      @label = Label.find(params[:id])
      if @label.update(label_params)
        flash[:notice] = "Label updated successfully"
        redirect_to board_path(@label.board)
      else
        flash[:error] = @label.errors.full_messages.to_sentence
        redirect_to edit_board_label_path(@label.board, @label)
      end
    end

    def destroy
      label = Label.find_by(id: params[:id])
      if label.destroy
        flash[:notice] = "Label deleted successfully"
      else
        flash[:error] = label.errors.full_messages.to_sentence
      end
      redirect_to board_path(label.board)
    end

    private

    def label_params
      params.require(:label).permit(:title, :color, :board_id)
    end
end
