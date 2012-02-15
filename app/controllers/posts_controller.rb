class PostsController < ApplicationController
  before_filter :find_post, :only => [:edit, :update]
  before_filter :check_ip_address, :only => [:edit, :update]


  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @post.ip_address = user_ip_address
    if @post.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(params[:post].slice(:title, :body))
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def find_post
    @post = Post[params[:id]]
    if !@post
      render :text => 'post not found', :status => 404
    end
  end

  def check_ip_address
    if @post.ip_address != user_ip_address
      render :text => 'unauthorized: wrong ip address', :status => 403
    end
  end
end
