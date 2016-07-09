class UserStationStatusesController < ApplicationController
  def edit
    @Station = Station.eager_load(:state, :company).find(params[:station_id])
    @StatusSearch = UserStationStatus.user_is(current_user).station_is(params[:station_id]).not_delete
    @StatusSearch.each do |s|
      $id = s.id
    end
    @Status = UserStationStatus.find($id)
    @Rosens = Section.eager_load(:rosen, :start_station, :end_station).where("sections.start_id = ? or sections.end_id = ?", params[:station_id], params[:station_id]).not_abolish.not_delete.group(:rosen_id)

    @arr = Array.new()

    @Rosens.each do |r|

      $prev_station_id = 0
      $next_station_id = 0

      $rosen_id = r.rosen_id
      $rosen_name = r.rosen.name
      $rosen_start_station_name = r.rosen.start_station.name
      $rosen_end_station_name = r.rosen.end_station.name

      @PrevStation = Section.eager_load(:start_station, :end_station).where("sections.end_id = ? and sections.rosen_id = ?", params[:station_id], r.rosen_id).not_abolish.not_delete

      if (@PrevStation.nil?) 
        $prev_station_name.nil
        $prev_station_id.nil
      end     
      @PrevStation.each do |p|
        $prev_station_name = p.start_station.name
        $prev_station_id = p.start_station.id
      end
      @NextStation = Section.eager_load(:start_station, :end_station).where("sections.start_id = ? and sections.rosen_id = ?", params[:station_id], r.rosen_id).not_abolish.not_delete

      @NextStation.each do |n|
        $next_station_name = n.end_station.name
        $next_station_id = n.end_station.id
      end  
      @arr.push [[$rosen_id, $rosen_name, $rosen_start_station_name, $rosen_end_station_name, $prev_station_name, $prev_station_id, $next_station_name, $next_station_id]]
    end
  end

  def update
    @Station = Station.eager_load(:state, :company).find(params[:station_id])
    @Rosens = Section.eager_load(:rosen, :start_station, :end_station).where("sections.start_id = ? or sections.end_id = ?", params[:station_id], params[:station_id]).not_abolish.not_delete.group(:rosen_id)
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
