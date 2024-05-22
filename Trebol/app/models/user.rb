class User < ApplicationRecord
    has_many :user_boards, dependent: :destroy
    has_many :boards, through: :user_boards

    has_many :created_tasks, class_name: 'Task', foreign_key: 'informer_id', dependent: :destroy
    has_many :assigned_tasks, class_name: 'Task', foreign_key: 'assignee_id', dependent: :destroy
    has_many :created_boards, class_name: 'Board', foreign_key: 'creator_id', dependent: :destroy

    validates :name, presence: { message: "must be present"}
    validates :email, presence: { message: "must be present"}, uniqueness: { message: "must be unique"}, format: { with: URI::MailTo::EMAIL_REGEXP, message: "format must be valid"}
    validates :password, presence: { message: "must be present"}, length: {minimum: 6, message: "must be at least 6 characters long"}
end
