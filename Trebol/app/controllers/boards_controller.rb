class BoardsController < ApplicationController
    def home
        @boards = Board.all
    end

    def index
        @boards = Board.all
    end

    def show
        @Board = Board.find_by(id: params[:id])
    end
end