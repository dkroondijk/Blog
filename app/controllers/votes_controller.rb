class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:create, :update, :destroy]

  def create
    @comment = Comment.find(params[:comment_id])
    @vote = current_user.votes.new(vote_params)
    @vote.comment = @comment
    post = @comment.post

    respond_to do |format|
      if @vote.save
        format.html { redirect_to post_path(post) }
        format.js { render }
      else
        format.html { redirect_to post_path(post) }
        format.js { render }
      end
    end        
  end

  def update
    @comment = Comment.find(params[:comment_id])
    @vote = Vote.find(params[:id])
    post = @vote.comment.post

    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to post_path(post) }
        format.js { render }
      else
        format.html { redirect_to post_path(post) }
        format.js { render }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    vote = Vote.find(params[:id])
    post = vote.comment.post
    
    respond_to do |format|
      vote.destroy
      format.html { redirect_to post_path(post) }
      format.js { render }
    end
      
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

  def find_comment
    comment = Comment.find(params[:comment_id])
  end

end
