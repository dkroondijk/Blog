class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = Comment.find(params[:comment_id])
    vote = current_user.votes.new(vote_params)
    vote.comment = comment
    post = comment.post

    if vote.save
      redirect_to post_path(post)
    else
      redirect_to post_path(post)
    end        
  end

  def update
    
  end

  def destroy

  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end

end
