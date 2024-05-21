class LabelsController < ApplicationController
    def new
      @label = Label.new(board_id: params[:board_id])
    end
  
    def create
      @label = Label.new(label_params)
      if @label.save
        flash[:notice] = "label created successfully"
        redirect_to board_path(@label.board)
      else
        flash[:error] = @label.errors.full_messages.to_sentence
        redirect_to new_board_label_path(@label.board)
      end
    end

    private
  
    def label_params
      params.require(:label).permit(:title, :color, :board_id)
    end
end