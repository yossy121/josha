class StationsController < ApplicationController
  def companyindex
    @Company = Company.find(params[:company_id])
    @Stations = Station.eager_load(:state, :user_station_statuses).company_is(params[:company_id]).station_user_is(current_user).not_delete.order(:name_ruby)
    @StationCount = Station.company_is(params[:company_id]).not_abolish.not_delete.count
    @VisitedCount = Station.eager_load(:state, :user_station_statuses).company_is(params[:company_id]).visit_true.station_user_is(current_user).not_delete.count
  end

  def stateindex
    @State = State.find(params[:state_id])
    @Stations = Station.eager_load(:company, :state, :user_station_statuses).state_is(params[:state_id]).station_user_is(current_user).not_delete.order('companies.category_id asc, companies.company_sub_id asc, name_ruby asc')
    @StationCount = Station.state_is(params[:state_id]).not_abolish.not_delete.count
    @VisitedCount = Station.eager_load(:state, :user_station_statuses).state_is(params[:state_id]).visit_true.station_user_is(current_user).not_delete.count
  end

  def rosenindex
    @Rosen = Rosen.find(params[:rosen_id])
    @Sections = Section.eager_load(:start_station, :end_station).rosen_is(params[:rosen_id]).not_abolish.not_delete.order("section_sub_id ASC")
    @SectionsLast = Section.eager_load(:start_station, :end_station).rosen_is(params[:rosen_id]).not_abolish.not_delete.order("section_sub_id DESC").limit(1)
  end

  def show
    @Station = Station.eager_load(:state, :company).find(params[:station_id])
    @StatusSearch = UserStationStatus.user_is(current_user).station_is(params[:station_id]).not_delete
    @StatusSearch.each do |s|
      $id = s.id
    end
    @Status = UserStationStatus.find($id)
    @Rosens = Section.eager_load(:rosen, :start_station, :end_station).where("sections.start_id = ? or sections.end_id = ?", params[:station_id], params[:station_id]
).not_abolish.not_delete.group(:rosen_id)
    @PrevStation = Section.eager_load(:rosen, :start_station, :end_station).where("sections.end_id = ?", params[:station_id]).not_delete
    @NextStation = Section.eager_load(:rosen, :start_station, :end_station).where("sections.start_id = ?", params[:station_id]).not_delete
  end
end
