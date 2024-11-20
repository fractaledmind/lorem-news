class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps
    end
    add_index :posts, :title, unique: true
  end
end
