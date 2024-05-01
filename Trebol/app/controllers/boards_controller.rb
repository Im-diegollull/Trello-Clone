class BoardsController < ApplicationController
    def home
        @boards = Board.all
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