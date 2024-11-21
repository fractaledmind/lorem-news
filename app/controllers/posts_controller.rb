class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_post, only: %i[ edit update destroy ]
  before_action :ensure_canonical_url, only: %i[ show edit update destroy ]
  allow_unauthenticated_access only: %i[ index show ]

  # GET /posts
  def index
    @posts = Post.all.order(created_at: :desc).limit(50)
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Current.user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Current.user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy!
    redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    def authorize_post
      raise NotAuthorized unless @post.user == Current.user
    end

    def ensure_canonical_url
      redirect_to @post if @post.to_param != params[:id]
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :body, tags: [] ])
    end
end
