class CreateTableStates < ActiveRecord::Migration[7.1]
  def change
    create_table :states do |t|
      t.references :board, null: false, foreign_key: true
      t.string :status, null: false, default: ''
      t.integer :board_position, null: false, default: ''

      t.timestamps
    end
  end
end
