class DashboardsController < ApplicationController
  def show
    unless current_user
      redirect_to signin_path
    end

    @Infos = Info.limit(5).order("publishing_date DESC")
  end
end
