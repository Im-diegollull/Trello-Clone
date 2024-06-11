class Attachment < ApplicationRecord
    belongs_to :task
    validate :set_published_at
    
    private
    
    def set_published_at
        self.published_at = Time.now unless published_at.present?
    end
end