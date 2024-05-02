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
end