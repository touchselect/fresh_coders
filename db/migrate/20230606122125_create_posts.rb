class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.integer :category_id
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
