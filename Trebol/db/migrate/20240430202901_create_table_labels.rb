class CreateTableLabels < ActiveRecord::Migration[7.1]
  def change
    create_table :labels do |t|
      t.references :board, null: false, foreign_key: true
      t.string :title, null: false, default: ''
      t.string :color, null: false, default: ''

      t.timestamps
    end
  end
end
