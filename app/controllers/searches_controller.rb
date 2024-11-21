class SearchesController < ApplicationController
  allow_unauthenticated_access

  def show
    @posts = if params[:query].present?
      Post.search(params[:query])
    else
      Post.none
    end
  end
end
