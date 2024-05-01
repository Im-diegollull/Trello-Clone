class AddColumnCreatorToBoard < ActiveRecord::Migration[7.1]
  def change
    add_reference :boards, :creator, null: false, foreign_key: { to_table: :users }
  end
end
