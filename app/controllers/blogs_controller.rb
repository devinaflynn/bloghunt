class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  impressionist :actions=>[:show]

  def index

    @tags = ActsAsTaggableOn::Tag.all

    if params[:most_viewed]
      case params[:most_viewed]
        when "day"
          daily_views = Impression.where(impressionable_type: "Blog").where("created_at >= ?", (DateTime.now - 24.hours)).group("impressionable_id").count
          daily_views = Hash[daily_views.sort_by{|key, value| value}.reverse]
          @blogs = []
          daily_views.keys.each do |blog_id|
            @blogs << Blog.find(blog_id)
          end
        when "week"
          daily_views = Impression.where(impressionable_type: "Blog").where("created_at >= ?", (DateTime.now - 1.week)).group("impressionable_id").count
          daily_views = Hash[daily_views.sort_by{|key, value| value}.reverse]
          @blogs = []
          daily_views.keys.each do |blog_id|
            @blogs << Blog.find(blog_id)
          end
        when "month"
          daily_views = Impression.where(impressionable_type: "Blog").where("created_at >= ?", (DateTime.now - 1.month)).group("impressionable_id").count
          daily_views = Hash[daily_views.sort_by{|key, value| value}.reverse]
          @blogs = []
          daily_views.keys.each do |blog_id|
            @blogs << Blog.find(blog_id)
          end 
         when "year"
          daily_views = Impression.where(impressionable_type: "Blog").where("created_at >= ?", (DateTime.now - 1.year)).group("impressionable_id").count
          daily_views = Hash[daily_views.sort_by{|key, value| value}.reverse]
          @blogs = []
          daily_views.keys.each do |blog_id|
            @blogs << Blog.find(blog_id)
          end  
      end
    elsif params[:tag]
      @blogs = Blog.tagged_with(params[:tag])
    else
      @blogs = Blog.all.paginate(:page => params[:page], :per_page => 30)
    end
  end

  def show
    @blogs = Blog.all
  end

  def new
    @blog = current_user.blogs.build
  end

  def edit

  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      redirect_to current_user, notice: 'blog was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to @blog, notice: 'blog was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def correct_user
      @blog = current_user.blogs.find_by(id: params[:id])
      redirect_to blogs_path, notice: "Not authorized to edit this blog" if @blog.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:name, :url, :description, :image, :tag_list)
    end
end
