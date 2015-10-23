class SubsController < ApplicationController

  before_action :set_sub, only: [:show, :edit, :update]
  before_action :verify_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      add_to_flash("Sub creation successful.", :errors)
      redirect_to sub_url(@sub)
    else
      errors_to_flash(@sub, true)
      render :new
    end
  end

  def edit

    render :edit
  end

  def update
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      errors_to_flash(@sub, true)
      render :edit
    end

  end

  private

  def set_sub
    @sub = Sub.find(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def verify_moderator
    unless current_user.id == @sub.moderator_id
      add_to_flash("Only the moderator can do that", :errors)
      redirect_to sub_url
    end
  end

end
