class CreateTableBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.string :name, null: false, default: ''
      t.datetime :published_at, null: false

      t.timestamps
    end
  end
end
