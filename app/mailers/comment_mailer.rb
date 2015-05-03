class CommentMailer < ApplicationMailer

  def notify_post_owner(user, posts)
    @posts = posts
    @user = user
    # @posts.each do |post|
    #   @comments = post.comments.where("created_at >= ?", Time.zone.now.beginning_of_day)
    # end
    
    mail(to: @user.email, subject: "Your Daily Comment Summary")

    # @post = @comments.post
    # @user = @post.user
    # comments = post.comments.where("created_at >= ?", Time.zone.now.beginning_of_day)
  end

end
