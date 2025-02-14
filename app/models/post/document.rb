class Post
  class Document < ApplicationRecord
    def self.build_index!
      connection.execute <<~SQL
        INSERT OR REPLACE INTO #{table_name}(rowid, title, body)
        SELECT rowid, title, body FROM #{module_parent.table_name};
      SQL
      connection.execute <<~SQL
        INSERT INTO #{table_name}(#{table_name}) VALUES('optimize');
      SQL
    end

    def self.matches(query, k: 10)
      select(
        :rowid,
        "row_number() OVER (ORDER BY rank) AS rank_number",
        rank: :score
      )
      .where("#{table_name} MATCH ?", query)
      .limit(k)
    end
  end
end
