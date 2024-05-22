class Label < ApplicationRecord
    belongs_to :board
    has_many :tasks

    validates :title, presence: { message: "must be present"}
    validates :color, presence: { message: "must be present"}
end
