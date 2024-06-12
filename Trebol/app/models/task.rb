class Task < ApplicationRecord
    belongs_to :state
    belongs_to :informer, class_name: 'User'
    belongs_to :assignee, class_name: 'User', optional: true
    belongs_to :label, optional: true
    has_many :attachments, dependent: :destroy

    validate :set_published_at

    #Assignment 3 corrections:
    validates :informer, presence: { message: "must be present"}
    validates :assignee, presence: { message: "must be present"}
    validates :title, presence: { message: "must be present"}
    validates :priority, presence: { message: "must be present"}
    validates :due_date, presence: { message: "must be present"}
    
    private
    
    def set_published_at
        self.published_at = Time.now unless published_at.present?
    end
end