class AppsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  impressionist :actions=>[:show]

  def index

    @tags = ActsAsTaggableOn::Tag.all

    if params[:most_viewed]
      case params[:most_viewed]
        when "day"
          daily_views = Impression.where(impressionable_type: "App").where("created_at >= ?", (DateTime.now - 24.hours)).group("impressionable_id").count
          daily_views = Hash[daily_views.sort_by{|key, value| value}.reverse]
          @apps = []
          daily_views.keys.each do |app_id|
            @apps << App.find(app_id)
          end
        when "week"
          daily_views = Impression.where(impressionable_type: "App").where("created_at >= ?", (DateTime.now - 1.week)).group("impressionable_id").count
          daily_views = Hash[daily_views.sort_by{|key, value| value}.reverse]
          @apps = []
          daily_views.keys.each do |app_id|
            @apps << App.find(app_id)
          end
        when "month"
          daily_views = Impression.where(impressionable_type: "App").where("created_at >= ?", (DateTime.now - 1.month)).group("impressionable_id").count
          daily_views = Hash[daily_views.sort_by{|key, value| value}.reverse]
          @apps = []
          daily_views.keys.each do |app_id|
            @apps << App.find(app_id)
          end 
      end
    elsif params[:tag]
      @apps = App.tagged_with(params[:tag])
    else
      @apps = App.all
    end
  end

  def show
    @apps = App.all
  end

  def new
    @app = current_user.apps.build
  end

  def edit

  end

  def create
    @app = current_user.apps.build(app_params)
    if @app.save
      redirect_to @app, notice: 'App was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @app.update(app_params)
      redirect_to @app, notice: 'App was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @app.destroy
    redirect_to apps_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end

    def correct_user
      @app = current_user.apps.find_by(id: params[:id])
      redirect_to apps_path, notice: "Not authorized to edit this App" if @app.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:name, :url, :image, :tag_list)
    end
end
