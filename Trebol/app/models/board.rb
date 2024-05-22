class Board < ApplicationRecord
    has_many :user_boards, dependent: :destroy
    has_many :users, through: :user_boards
    has_many :labels,  dependent: :destroy
    has_many :states, dependent: :destroy
    belongs_to :creator, class_name: 'User'

    before_validation :set_published_at
    after_create :create_basic_states

    validates :name, presence: { message: "must be present"}
    validates :creator, presence: { message: "must exists"}

    private

    def set_published_at
      self.published_at = Time.now unless published_at.present?
    end

    def create_basic_states
      states.create(status: 'TODO')
      states.create(status: 'WIP')
      states.create(status: 'DONE')
    end
  end
