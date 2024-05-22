class State < ApplicationRecord
    belongs_to :board
    has_many :tasks, dependent: :destroy

    validates :status, presence: { message: "must be present"}
end
