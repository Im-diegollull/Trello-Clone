class User < ApplicationRecord
    has_many :user_boards, dependent: :destroy
    has_many :boards, through: :user_boards
    
    has_many :created_tasks, class_name: 'Task', foreign_key: 'informer_id', dependent: :destroy
    has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id', dependent: :destroy
    has_many :created_boards, class_name: 'Board', foreign_key: 'creator_id', dependent: :destroy
end