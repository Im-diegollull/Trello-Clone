# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Attachment.delete_all
Task.delete_all
Label.delete_all
State.delete_all
UserBoard.delete_all
Board.delete_all
User.delete_all

# Users
usr1 = User.create!(
    name: "Roger Federer",
    email: "roger@example.com",
    password: "rfed123"
)

usr2 = User.create!(
    name: "Rafael Nadal",
    email: "rafa@example.com",
    password: "rnan456"
)

usr3 = User.create!(
    name: "Novak Djokovic",
    email: "novak@example.com",
    password: "ndjo789"
)

# Boards
brd1 = Board.create!(
    name: "Roger Federer Table",
    published_at: Time.now,
    creator: usr1,

)

brd2 = Board.create!(
    name: "Rafael Nadal Table",
    published_at: Time.now,
    creator: usr2,
 )

brd3 = Board.create!(
    name: " Novak Djokovic Table ",
    published_at: Time.now,
    creator: usr3,
)

usr1.boards << brd1
usr2.boards << brd2
usr3.boards << brd3

# State
st1 = State.create!(
    board: brd1,
    status: "In progress",
    board_position: 2
)

st2 = State.create!(
    board: brd1,
    status: "Done",
    board_position: 3
)

st3 = State.create!(
    board: brd1,
    status: "On hold",
    board_position: 1
)

st4 = State.create!(
    board: brd1,
    status: "Next up",
    board_position: 0
)

st5 = State.create!(
    board: brd2,
    status: "In progress",
    board_position: 2
)

st6 = State.create!(
    board: brd2,
    status: "Done",
    board_position: 3
)

st7 = State.create!(
    board: brd2,
    status: "On hold",
    board_position: 1
)

st8 = State.create!(
    board: brd2,
    status: "Next up",
    board_position: 0
)

st9 = State.create!(
    board: brd3,
    status: "In progress",
    board_position: 2
)
st10 = State.create!(
    board: brd3,
    status: "Done",
    board_position: 3
)

st11 = State.create!(
    board: brd3,
    status: "On hold",
    board_position: 1
)

st12 = State.create!(
    board: brd3,
    status: "Next up",
    board_position: 0
)

# Tasks
tsk1 = Task.create!(
    state: st1,
    informer: usr1,
    assignee: usr2,
    title: "Task 1 Title",
    description: "Task 1 Description",
    priority: 1,
    published_at: Time.now,
)

tsk2 = Task.create!(
    state: st2,
    informer: usr1,
    assignee: usr3,
    title: "Task 2 Title",
    description: "Task 2 Description",
    priority: 1,
    published_at: Time.now,
)
tsk3 = Task.create!(
    state: st3,
    informer: usr2,
    assignee: usr1,
    title: "Task 3 Title",
    description: "Task 3 Description",
    priority: 1,
    published_at: Time.now,
)
tsk4 = Task.create!(
    state: st4,
    informer: usr2,
    assignee: usr3,
    title: "Task 4 Title",
    description: "Task 4 Description",
    priority: 1,
    published_at: Time.now,
)
tsk5 = Task.create!(
    state: st1,
    informer: usr3,
    assignee: usr1,
    title: "Task 5 Title",
    description: "Task 5 Description",
    priority: 1,
    published_at: Time.now,
)

tsk6 = Task.create!(
    state: st5,
    informer: usr1,
    assignee: usr2,
    title: "Task 6 Title",
    description: "Task 6 Description",
    priority: 1,
    published_at: Time.now,
)

tsk7 = Task.create!(
    state: st6,
    informer: usr1,
    assignee: usr3,
    title: "Task 7 Title",
    description: "Task 7 Description",
    priority: 1,
    published_at: Time.now,
)
tsk8 = Task.create!(
    state: st7,
    informer: usr2,
    assignee: usr1,
    title: "Task 8 Title",
    description: "Task 8 Description",
    priority: 1,
    published_at: Time.now,
)
tsk9 = Task.create!(
    state: st8,
    informer: usr2,
    assignee: usr3,
    title: "Task 9 Title",
    description: "Task 9 Description",
    priority: 1,
    published_at: Time.now,
)
tsk10 = Task.create!(
    state: st5,
    informer: usr3,
    assignee: usr1,
    title: "Task 10 Title",
    description: "Task 10 Description",
    priority: 1,
    published_at: Time.now,
)

tsk11 = Task.create!(
    state: st9,
    informer: usr1,
    assignee: usr2,
    title: "Task 11 Title",
    description: "Task 11 Description",
    priority: 1,
    published_at: Time.now,
)

tsk12 = Task.create!(
    state: st10,
    informer: usr1,
    assignee: usr3,
    title: "Task 12 Title",
    description: "Task 12 Description",
    priority: 1,
    published_at: Time.now,
)
tsk13 = Task.create!(
    state: st11,
    informer: usr2,
    assignee: usr1,
    title: "Task 13 Title",
    description: "Task 13 Description",
    priority: 1,
    published_at: Time.now,
)
tsk14 = Task.create!(
    state: st12,
    informer: usr2,
    assignee: usr3,
    title: "Task 14 Title",
    description: "Task 14 Description",
    priority: 1,
    published_at: Time.now,
)
tsk15 = Task.create!(
    state: st9,
    informer: usr3,
    assignee: usr1,
    title: "Task 15 Title",
    description: "Task 15 Description",
    priority: 1,
    published_at: Time.now,
)