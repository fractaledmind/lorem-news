class Post < ApplicationRecord
  include ArrayColumns

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
  validate :tags_is_array_of_strings
  array_columns :tags

  def self.find(identifier)
    return super if identifier.is_a?(Integer)

    public_id = identifier.split('-').last
    find_by(public_id: public_id)
  end

  def to_param
    return nil unless persisted?

    [title.parameterize, public_id].join("-")
  end

  private

  def tags_is_array_of_strings
    return if tags.is_a?(Array) && tags.all?(String)

    errors.add(:tags, :invalid)
  end
end
