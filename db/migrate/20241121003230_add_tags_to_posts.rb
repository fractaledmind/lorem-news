class AddTagsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :tags, :json, null: false, default: []
    add_check_constraint :posts, "JSON_TYPE(tags) = 'array'", name: 'post_tags_is_array'
  end
end
