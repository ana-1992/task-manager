class Admin::UsersController < ApplicationController
  include AuthHelper
  before_action :authenticate_user!, :authorize
  helper_method :current_user

  def show
    @user = User.find(params[:id])
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result.order(:type).order(:id).page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def authorize
    render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false) if forbidden?
  end

  def forbidden?
    !current_user.is_a?(Admin)
  end

  def create
    @user = User.new(user_params)
     if @user.save
      redirect_to admin_users_url
    else
      render :new_admin_user_url
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_url
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
  
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :type)
  end
end
