class PostsController < ApplicationController
  before_filter :find_post, :only => [:edit, :update]
  before_filter :check_ip_address, :only => [:edit, :update]


  def index
    @posts = Post.all
  end

  def new
  end

  def create
    @post = Post.new(params[:post])
    @post.ip_address = request.env['REMOTE_ADDR']
    @post.save
    #self.response_body = ''
    redirect_to root_url
  end

  def edit
  end

  def update
    @post.update(params[:post].slice(:title, :body))
    redirect_to root_url
  end

  private

  def find_post
    @post = Post[params[:id]]
    if !@post
      render :text => 'post not found', :status => 404
    end
  end

  def check_ip_address
    if @post.ip_address != request.env['REMOTE_ADDR']
      render :text => 'unauthorized: wrong ip address', :status => 403
    end
  end
end
