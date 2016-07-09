class DashboardsController < ApplicationController
  def show
    unless current_user
      redirect_to signin_path
    end

    @Infos = Info.limit(5).order("publishing_date DESC")
    @Rosen_sum = Rosen.eager_load(:start_station, :end_station).not_delete.sum(:kilo)
    @Ride_sum = Rosen.eager_load(:start_station, :end_station, :user_rosen_statuses).rosen_user_is(current_user).not_delete.sum(:ride_kilo_sum)
    @StationCount = Station.not_abolish.not_delete.count
    @VisitedCount = Station.eager_load(:state, :user_station_statuses).visit_true.station_user_is(current_user).not_abolish.not_delete.count

  end
end
