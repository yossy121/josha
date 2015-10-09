class StationsController < ApplicationController
  def index
    @Company = Company.find(params[:company_id])
    @Stations = Station.eager_load(:state).where(["stations.company_id = ? and stations.delete_flag = ?", params[:company_id], 0]).order(:name_ruby)
  end

  def show
    @Station = Station.eager_load(:state, :company).find(params[:station_id])
  end
end
