class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.friendly.find(params[:post_id])
    like = current_user.likes.new
    like.post = post

    if like.save
      redirect_to post_path(post), notice: "Liked!"
    else
      redirect_to post_path(post), notice: "Can't Like!"
    end

  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy
    redirect_to root_path
  end

end
