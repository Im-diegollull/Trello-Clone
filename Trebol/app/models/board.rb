class Board < ApplicationRecord
    has_many :user_boards
    has_many :users, through: :user_boards
    has_many :labels
    has_many :states
    belongs_to :creator, class_name: 'User'

    validate :set_published_at
    private
        def set_published_at
            self.published_at = Time.now unless published_at.present?
        end
end