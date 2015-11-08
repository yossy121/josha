class StationsController < ApplicationController
  def companyindex
    @Company = Company.find(params[:company_id])
    @Stations = Station.eager_load(:state, :user_station_statuses).company_is(params[:company_id]).station_user_is(current_user).order(:name_ruby)
    @StationCount = Station.company_is(params[:company_id]).not_abolish.count
    @VisitedCount = Station.eager_load(:state, :user_station_statuses).company_is(params[:company_id]).visit_true.station_user_is(current_user).count
  end

  def stateindex
    @State = State.find(params[:state_id])
    @Stations = Station.eager_load(:company, :state, :user_station_statuses).state_is(params[:state_id]).station_user_is(current_user).order('companies.category_id asc, companies.company_sub_id asc, name_ruby asc')
    @StationCount = Station.state_is(params[:state_id]).not_abolish.count
    @VisitedCount = Station.eager_load(:state, :user_station_statuses).state_is(params[:state_id]).visit_true.station_user_is(current_user).count
  end

  def show
    @Station = Station.eager_load(:state, :company).find(params[:station_id])
    @Status = Station.eager_load(:state, :company, :user_station_statuses).where(["stations.id = ? and user_station_statuses.station_id = ? and user_station_statuses.user_id = ?", params[:station_id], params[:station_id], current_user.id])
  end
end
