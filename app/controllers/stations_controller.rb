class StationsController < ApplicationController
  def index
    @Company = Company.find(params[:company_id])
    @Stations = Station.eager_load(:state, :user_station_statuses).where(["stations.company_id = ? and stations.delete_flag = ? and user_station_statuses.user_id = ?", params[:company_id], 0, current_user.id]).order(:name_ruby)
#    @Stations = Station.eager_load(:state).where(["stations.company_id = ? and stations.delete_flag = ?", params[:company_id], 0]).order(:name_ruby)
  end

  def show
    @Station = Station.eager_load(:state, :company).find(params[:station_id])
    @Status = Station.eager_load(:state, :company, :user_station_statuses).where(["stations.id = ? and user_station_statuses.station_id = ? and user_station_statuses.user_id = ?", params[:station_id], params[:station_id], current_user.id])
  end
end
