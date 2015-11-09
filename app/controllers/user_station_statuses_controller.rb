class UserStationStatusesController < ApplicationController
  def edit
    @Station = Station.eager_load(:state, :company).find(params[:station_id])
    @StatusSearch = UserStationStatus.user_is(current_user).station_is(params[:station_id]).not_delete
    @StatusSearch.each do |s|
      $id = s.id
    end
    @Status = UserStationStatus.find($id)
  end

  def update
    @StatusSearch = UserStationStatus.user_is(current_user).station_is(params[:station_id]).not_delete
    @StatusSearch.each do |s|
      $id = s.id
    end
    @Status = UserStationStatus.find($id)
    if @Status.update(visit_param)
      redirect_to @Status, :notice => '更新しました。'
    else
      render :template => 'user_station_status/edit'
    end
  end

  private

  def visit_param
    params.require(:user_station_status).permit(:visit_day, :visit_chk)
  end
end
