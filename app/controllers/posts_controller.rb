class PostsController < ApplicationController
  before_action :verify_logged_in
  before_action :set_post, except: [:new, :create]

  def show
    render :show
  end

  def new

    @post = Post.new

    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    
    if @post.save
      redirect_to post_url(@post)
    else
      errors_to_flash(@post, true)
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      errors_to_flash(@post, true)

      render :edit
    end
  end

  def destroy
    @post.destroy
    add_to_flash("#{@post.title} deleted", :errors)
    redirect_to sub_url(@post.sub)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end

end
