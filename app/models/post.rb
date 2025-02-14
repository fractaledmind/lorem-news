class Post < ApplicationRecord
  include ArrayColumns

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
  validate :tags_is_array_of_strings
  array_columns :tags

  after_commit -> { Post::Document.build_index! }

  def self.find(identifier)
    return super if identifier.is_a?(Integer)

    public_id = identifier.split("-").last
    find_by(public_id: public_id)
  end

  def to_param
    return nil unless persisted?

    [ title.parameterize, public_id ].join("-")
  end

  def self.search(query)
      with(
        fts_matches: Post::Document.matches(query)
      )
      .from("fts_matches")
      .joins(
        "INNER JOIN posts ON posts.rowid = fts_matches.rowid"
      )
      .select(
        posts: [ :id, :body, :title, :public_id, :user_id, :created_at, :updated_at, :tags ],
        fts_matches: { rank_number: :fts_rank, score: :fts_score }
      )
      .order(fts_rank: :desc)
  end

  private

  def tags_is_array_of_strings
    return if tags.is_a?(Array) && tags.all?(String)

    errors.add(:tags, :invalid)
  end
end
