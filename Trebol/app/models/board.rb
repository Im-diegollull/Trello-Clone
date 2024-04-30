class Board < ApplicationRecord
    has_many :user_boards
    has_many :users, through: :user_boards
    has_many :labels
    has_many :states
end