class Task < ApplicationRecord
    belongs_to :state
    belongs_to :informer, class_name: 'User'
    belongs_to :assignee, class_name: 'User', optional: true
    belongs_to :label, optional: true
    has_many :attachments, optional: true
end