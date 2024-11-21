class AddPublicIdToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :public_id, :string,
      as: "HEX(id) || FORMAT('%X', unixepoch(created_at))",
      stored: false
    add_index :posts, :public_id, unique: true
  end
end
