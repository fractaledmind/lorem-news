class Post < ApplicationRecord
  include ArrayColumns

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
  validate :tags_is_array_of_strings
  array_columns :tags

  private

  def tags_is_array_of_strings
    return if tags.is_a?(Array) && tags.all?(String)

    errors.add(:tags, :invalid)
  end
end
