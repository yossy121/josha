class StationsController < ApplicationController
  def companyindex
    @Company = Company.find(params[:company_id])
    @Stations = Station.eager_load(:state, :user_station_statuses).company_is(params[:company_id]).station_user_is(current_user).not_delete.order(:name_ruby)
    @StationCount = Station.company_is(params[:company_id]).not_abolish.not_delete.count
    @VisitedCount = Station.eager_load(:state, :user_station_statuses).company_is(params[:company_id]).visit_true.station_user_is(current_user).not_abolish.not_delete.count
    @VisitedAboCount = Station.eager_load(:state, :user_station_statuses).company_is(params[:company_id]).visit_true.station_user_is(current_user).abolish.not_delete.count
  end

  def stateindex
    @State = State.find(params[:state_id])
    @Stations = Station.eager_load(:company, :state, :user_station_statuses).state_is(params[:state_id]).station_user_is(current_user).not_delete.order('companies.category_id asc, companies.company_sub_id asc, name_ruby asc')
    @StationCount = Station.state_is(params[:state_id]).not_abolish.not_delete.count
    @VisitedCount = Station.eager_load(:state, :user_station_statuses).state_is(params[:state_id]).visit_true.station_user_is(current_user).not_abolish.not_delete.count
    @VisitedAboCount = Station.eager_load(:state, :user_station_statuses).state_is(params[:state_id]).visit_true.station_user_is(current_user).abolish.not_delete.count
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

    @arr = Array.new()

    @Rosens.each do |r|

      $rosen_id = r.rosen_id
      $rosen_name = r.rosen.name
      $rosen_start_station_name = r.rosen.start_station.name
      $rosen_end_station_name = r.rosen.end_station.name

      @PrevStation = Section.eager_load(:start_station, :end_station).where("sections.end_id = ? and sections.rosen_id = ?", params[:station_id], r.rosen_id).not_delete

      if (@PrevStation.nil?) 
        $prev_station_name.nil
        $prev_station_id.nil
      end     
      @PrevStation.each do |p|
        $prev_station_name = p.start_station.name
        $prev_station_id = p.start_station.id
      end
      @NextStation = Section.eager_load(:start_station, :end_station).where("sections.start_id = ? and sections.rosen_id = ?", params[:station_id], r.rosen_id).not_delete

      @NextStation.each do |n|
        $next_station_name = n.end_station.name
        $next_station_id = n.end_station.id
      end  
      @arr.push [[$rosen_id, $rosen_name, $rosen_start_station_name, $rosen_end_station_name, $prev_station_name, $prev_station_id, $next_station_name, $next_station_id]]
    end

  end
end
