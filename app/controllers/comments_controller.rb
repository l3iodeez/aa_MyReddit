class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    unless @comment.save
      add_to_flash("You made a comment", :errors)
    end
    redirect_to post_url(@post)
  end
private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
