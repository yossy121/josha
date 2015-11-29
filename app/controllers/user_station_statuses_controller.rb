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
    @Station = Station.eager_load(:state, :company).find(params[:station_id])
    @StatusSearch = UserStationStatus.user_is(current_user).station_is(params[:station_id]).not_delete
    @StatusSearch.each do |s|
      $id = s.id
    end
    @Status = UserStationStatus.find($id)

# 日付が入力されていた場合はチェックフラグを入れる処理
    if params[:user_station_status]["visit_day(1i)"].present? and params[:user_station_status]["visit_day(2i)"].present? and params[:user_station_status]["visit_day(3i)"].present?
      params[:user_station_status][:visit_chk] = '1'
    end

    if @Status.update(visit_param)
      redirect_to ({:controller => 'stations', :action => 'show'}), :notice => '更新しました。'
    else
      render :template => 'user_station_status/edit'
    end
  end

  private

  def visit_param
    params.require(:user_station_status).permit(:visit_day, :visit_chk)
  end
end
