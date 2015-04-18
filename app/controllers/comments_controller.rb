class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [:create]
#   before_action :find_comment, only: [:show, :edit, :update, :destroy]

  def create
    @post         = Post.friendly.find(params[:post_id])
    @comment      = Comment.new(comment_params)
    @comment.user = current_user

    # this associates the comment with a specific post
    # otherwise the post_id would be blank
    @comment.post = @post

    # respond_to used for JS AJAX request called by form --> remote: true
    respond_to do |format|
      if @comment.save
        # send notification email to post owner
        PostMailer.notify_post_owner(@comment).deliver_later
        # responds to html requests
        format.html { redirect_to post_path(@post) }
        # responds to js requests, will render "create.js.erb"
        format.js { render }
      else
        format.html { render "/posts/show" }
        format.js { render }
      end
    end

  end

#   def edit
#   end

#   def update
#     if @comment.update(comment_params)
#       redirect_to comment_path(@comment)
#     else
#       render :edit
#     end
#   end

#   def destroy
#     @comment.destroy
#     redirect_to comments_path
#   end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end

#   def find_comment
#     @comment = Comment.find(params[:id])
#   end  
  
end
