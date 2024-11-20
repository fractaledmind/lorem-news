class CommentsController < ApplicationController
  before_action :set_post, only: %i[ create ]
  before_action :set_comment, only: %i[ edit update destroy ]

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = @post.comments.new(comment_params.merge(user: Current.user))

    if @comment.save
      redirect_to @comment.post, notice: "Comment was successfully created."
    else
      @post = @comment.post
      render "posts/show", status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      redirect_to @comment.post, notice: "Comment was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy!
    redirect_to @comment.post, notice: "Comment was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:post_id))
    end

    def set_comment
      @comment = Comment.find(params.expect(:id))
      raise NotAuthorized unless @comment.user == Current.user
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :body ])
    end
end
