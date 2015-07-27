class UsersController < ApplicationController
#before_filter :authenticate_user!
  impressionist :actions=>[:show]

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs

    respond_to do |format|
        format.html # show.html.erb
        format.xml { render :xml => @user }
    end
  end

end


