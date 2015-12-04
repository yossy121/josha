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

    day = Time.now.beginning_of_day

# 未来日付だった場合にエラーを返す処理
    if (params[:user_station_status]["visit_day(1i)"].to_i > day.year.to_i)
      redirect_to ({:controller => 'user_station_statuses', :action => 'edit'}), :alert => '未来日付は指定できません。' and return
    elsif (params[:user_station_status]["visit_day(1i)"].to_i == day.year.to_i) && (params[:user_station_status]["visit_day(2i)"].to_i > day.month.to_i)
      redirect_to ({:controller => 'user_station_statuses', :action => 'edit'}), :alert => '未来日付は指定できません。' and return
    elsif (params[:user_station_status]["visit_day(1i)"].to_i == day.year.to_i) && (params[:user_station_status]["visit_day(2i)"].to_i == day.month.to_i) && (params[:user_station_status]["visit_day(3i)"].to_i > day.day.to_i)
      redirect_to ({:controller => 'user_station_statuses', :action => 'edit'}), :alert => '未来日付は指定できません。' and return
    end

# 日付の判定
    if (params[:user_station_status]["visit_day(2i)"] == "4" || params[:user_station_status]["visit_day(2i)"] == "6" || params[:user_station_status]["visit_day(2i)"] == "9" || params[:user_station_status]["visit_day(2i)"] == "11") && params[:user_station_status]["visit_day(3i)"].to_i > 30
      redirect_to ({:controller => 'user_station_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    elsif (params[:user_station_status]["visit_day(2i)"] == "2") && (params[:user_station_status]["visit_day(1i)"].to_i % 4 != 0) && (params[:user_station_status]["visit_day(3i)"].to_i > 28)
      redirect_to ({:controller => 'user_station_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    elsif (params[:user_station_status]["visit_day(2i)"] == "2") && (params[:user_station_status]["visit_day(1i)"].to_i % 4 == 0) && (params[:user_station_status]["visit_day(1i)"].to_i % 100 != 0) && (params[:user_station_status]["visit_day(3i)"].to_i > 29)
      redirect_to ({:controller => 'user_station_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    elsif (params[:user_station_status]["visit_day(2i)"] == "2") && (params[:user_station_status]["visit_day(1i)"].to_i % 4 == 0) && (params[:user_station_status]["visit_day(1i)"].to_i % 100 == 0) && (params[:user_station_status]["visit_day(1i)"].to_i % 400 != 0) && (params[:user_station_status]["visit_day(3i)"].to_i > 28)
      redirect_to ({:controller => 'user_station_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    elsif (params[:user_station_status]["visit_day(2i)"] == "2") && (params[:user_station_status]["visit_day(1i)"].to_i % 4 == 0) && (params[:user_station_status]["visit_day(1i)"].to_i % 100 == 0) && (params[:user_station_status]["visit_day(1i)"].to_i % 400 == 0) && (params[:user_station_status]["visit_day(3i)"].to_i > 29)
      redirect_to ({:controller => 'user_station_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    end

# 日付が入力されていた場合にチェックフラグを入れる処理
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
