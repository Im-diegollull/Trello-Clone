class CreateTableTask < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :state, null: false, foreign_key: true
      t.references :informer, null: false, foreign_key: { to_table: :users }
      t.references :assignee, null: true, foreign_key: { to_table: :users } # Puede iniciarse sin assignee y luego definir uno
      t.references :label, null: true, foreign_key: true # Puede iniciarse sin label y luego definir uno
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.integer :priority, null: false, default: 0
      t.datetime :due_date, null: true # Puede iniciarse sin due_date y luego definir uno
      t.datetime :published_at, null: false

      t.timestamps
    end
  end
end
