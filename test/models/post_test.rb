require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "belongs to user" do
    post = Post.new(user: nil)
    post.valid?
    assert post.errors.of_kind? :user, :blank
  end

  test "title cannot be nil" do
    post = Post.new(title: nil)
    post.valid?
    assert post.errors.of_kind? :title, :blank
  end

  test "title must be unique" do
    one = posts(:one)
    post = Post.new(title: one.title)
    post.valid?
    assert post.errors.of_kind? :title, :taken
  end

  test "title must be more than 5 characters" do
    post = Post.new(title: "1234")
    post.valid?
    assert post.errors.of_kind? :title, :too_short
  end
end
