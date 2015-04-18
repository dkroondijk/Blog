class PostMailer < ApplicationMailer

  def notify_post_owner(comment)
    @comment = comment
    @post = comment.post
    @user = @post.user
    mail(to: @user.email, subject: "New comment on your blog post!")
  end

end
