class FavouritesController < ApplicationController

  before_action :authenticate_user!

  def index
    @posts = current_user.favourited_posts
  end

  def create
    @post = Post.friendly.find(params[:post_id])
    favourite = current_user.favourites.new
    favourite.post = @post

    respond_to do |format|
      if favourite.save
        format.html { redirect_to root_path }
        format.js { render }
      else
        format.html { redirect_to root_path }
        format.js { render }
      end
    end
  end

  def destroy
    @favourite = current_user.favourites.find(params[:id])
    @post = @favourite.post
    @favourite.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render }
    end
  end

end
