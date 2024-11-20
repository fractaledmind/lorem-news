require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "belongs to post" do
    comment = Comment.new(post: nil)
    comment.valid?
    assert comment.errors.of_kind? :post, :blank
  end

  test "belongs to user" do
    comment = Comment.new(user: nil)
    comment.valid?
    assert comment.errors.of_kind? :user, :blank
  end

  test "body cannot be nil" do
    comment = Comment.new(body: nil)
    comment.valid?
    assert comment.errors.of_kind? :body, :blank
  end

  test "body must be more than 5 characters" do
    comment = Comment.new(body: "1234")
    comment.valid?
    assert comment.errors.of_kind? :body, :too_short
  end
end
