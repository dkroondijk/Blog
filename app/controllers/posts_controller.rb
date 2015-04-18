class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:edit, :update, :destroy]

	def index
    if user_signed_in?
      if params[:search]
        @posts = Post.search(params[:search]).most_recent
      else
  		  @posts = Post.all.most_recent
      end
    else
      @posts = Post.all.most_recent
    end
	end

	def new
		@post = Post.new
	end

  def create
    @post = current_user.posts.new()
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @post.image = params[:post][:image]

    if @post.save
      split_tag_string(post_params[:tags_attributes].values[0][:name], @post)
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    # taken out of before_action to manage permissions for 'find_post' method
    @post = Post.friendly.find(params[:id])

    @comment = Comment.new
    @comments = @post.comments.most_recent
  end

  def edit

  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end


  private

  def find_post
    @post = Post.friendly.find(params[:id])
    redirect_to root_path, alert: "access denied" unless can? :manage, @post
  end

  def post_params
    params.require(:post).permit(:title, :body, :image,
      tags_attributes: [:id, :name])
  end

  def split_tag_string(tag_string, post)
    tags = tag_string.split(",")

    tags.each do |tag|
      tag.strip!
      tag_name = Tag.new(name: tag)
      tag_name.save
      post.tags << tag_name
    end

  end

end
