class DashboardsController < ApplicationController
  def show
    unless current_user
      redirect_to signin_path
    end
  end
end
