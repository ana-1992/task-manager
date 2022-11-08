class Admin::UsersController < ApplicationController
  include AuthHelper
  before_action :authenticate_user!, :authorize

  def show
    @user = User.find(params[:id])
  end

  def authorize
    render(file: File.join(Rails.root, 'public/403.html'), status: 403, layout: false) if forbidden?
  end

  def forbidden?
    !current_user.is_a?(Admin)
  end
end
