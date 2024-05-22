class CreateTableAttachments < ActiveRecord::Migration[7.1]
  def change
    create_table :attachments do |t|
      t.references :task, null: false, foreign_key: true
      t.string :file_link, null: false, default: ''
      t.string :comment, null: false, default: ''
      t.datetime :published_at, null: false
      
      t.timestamps
    end
  end
end
