class PostsController < ApplicationController
 before_action :authenticate_user
  
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def new
    if @current_user == nil
      redirect_to("login")
    end
  end

  def create
    @post = Post.new(
      content: params[:content],
      due_date: params[:due_date],
      executor: params[:executor],
      user_id: @current_user.id,
      if params[:image]
          @post.image_name = "#{@post.id}.jpg"
          image = params[:image]
          File.binwrite("public/post_images/#{@post.image_name}",image.read)
      end
    )
    @post.save
    redirect_to("/posts/index")
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.due_date = params[:due_date]
    @post.executor = params[:executor]
    if params[:image]
        @post.image_name = "#{@post.id}.jpg"
        image = params[:image]
        File.binwrite("public/post_images/#{@post.image_name}",image.read)
    end
    @post.save
    redirect_to("/posts/index")
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/posts/index")
  end
end