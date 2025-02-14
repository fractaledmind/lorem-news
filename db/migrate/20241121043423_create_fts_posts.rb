class CreateFtsPosts < ActiveRecord::Migration[8.0]
  def change
    create_virtual_table :post_documents, :fts5,
      [ :title, :body, "content=''", "contentless_delete=1", "tokenize='porter unicode61 remove_diacritics 2'" ]
  end
end
