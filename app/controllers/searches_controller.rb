class SearchesController < ApplicationController
  allow_unauthenticated_access

  def show
    @posts = Post.search(params[:query])
  end
end
