namespace :daily_summary do
  desc "creates daily summary of comments"
  task comment_list: :environment do

    users = User.all

    users.each do |user|
      posts = user.posts
      CommentMailer.notify_post_owner(user, posts).deliver
      # posts.each do |post|
        # comments = post.comments.where("created_at >= ?", Time.zone.now.beginning_of_day)
      # end
    end

  end

end
