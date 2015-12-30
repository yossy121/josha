class UserSectionStatusesController < ApplicationController
  def edit
    @Rosen = Rosen.find(params[:rosen_id])
    @Sections = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).section_user_is(current_user).order("section_sub_id ASC")
  end

  def update 
    @Rosen = Rosen.find(params[:rosen_id])
    @Sections = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).section_user_is(current_user).order("section_sub_id ASC")

    if params[:user_section_status][:startcheck] == '0' || params[:user_section_status][:endcheck] == '0'
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '「始区間」または「終区間」を指定してください。' and return
    end

    day = Time.now.beginning_of_day

# 未来日付だった場合にエラーを返す処理
    if (params[:user_section_status]["ride_day(1i)"].to_i > day.year.to_i)
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '未来日付は指定できません。' and return
    elsif (params[:user_section_status]["ride_day(1i)"].to_i == day.year.to_i) && (params[:user_section_status]["ride_day(2i)"].to_i > day.month.to_i)
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '未来日付は指定できません。' and return
    elsif (params[:user_section_status]["ride_day(1i)"].to_i == day.year.to_i) && (params[:user_section_status]["ride_day(2i)"].to_i == day.month.to_i) && (params[:user_section_status]["ride_day(3i)"].to_i > day.day.to_i)
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '未来日付は指定できません。' and return
    end

# 日付の判定
    if (params[:user_section_status]["ride_day(2i)"] == "4" || params[:user_section_status]["ride_day(2i)"] == "6" || params[:user_section_status]["ride_day(2i)"] == "9" || params[:user_section_status]["ride_day(2i)"] == "11") && params[:user_section_status]["ride_day(3i)"].to_i > 30
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    elsif (params[:user_section_status]["ride_day(2i)"] == "2") && (params[:user_section_status]["ride_day(1i)"].to_i % 4 != 0) && (params[:user_section_status]["ride_day(3i)"].to_i > 28)
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    elsif (params[:user_section_status]["ride_day(2i)"] == "2") && (params[:user_section_status]["ride_day(1i)"].to_i % 4 == 0) && (params[:user_section_status]["ride_day(1i)"].to_i % 100 != 0) && (params[:user_section_status]["ride_day(3i)"].to_i > 29)
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    elsif (params[:user_section_status]["ride_day(2i)"] == "2") && (params[:user_section_status]["ride_day(1i)"].to_i % 4 == 0) && (params[:user_section_status]["ride_day(1i)"].to_i % 100 == 0) && (params[:user_section_status]["ride_day(1i)"].to_i % 400 != 0) && (params[:user_section_status]["ride_day(3i)"].to_i > 28)
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    elsif (params[:user_section_status]["ride_day(2i)"] == "2") && (params[:user_section_status]["ride_day(1i)"].to_i % 4 == 0) && (params[:user_section_status]["ride_day(1i)"].to_i % 100 == 0) && (params[:user_section_status]["ride_day(1i)"].to_i % 400 == 0) && (params[:user_section_status]["ride_day(3i)"].to_i > 29)
      redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :alert => '日付に誤りがあります。' and return
    end

    if params[:user_section_status][:startcheck].to_i > params[:user_section_status][:endcheck].to_i
      tmp = params[:user_section_status][:endcheck]
      params[:user_section_status][:endcheck] = params[:user_section_status][:startcheck]
      params[:user_section_status][:startcheck] = tmp
    end

# 処理が実行されたら、チェックフラグを立てる。
    params[:user_section_status][:ride_chk] = '1'

# 削除ボタンが実行されたら、チェックフラグと日付を消す。
    if params[:erase_button]
      params[:user_section_status][:ride_chk] = '0'
      params[:user_section_status][:ride_day] = nil
    end

    @StatusSearch = UserSectionStatus.eager_load(:section).where("sections.rosen_id = ?", params[:rosen_id]).where("user_section_statuses.user_id = ?", current_user).where("sections.section_sub_id": params[:user_section_status][:startcheck]..params[:user_section_status][:endcheck])

    @StatusSearch.each do |s|
      $id = s.id
      if UserSectionStatus.find($id).update(ride_param)
      else
        render :template => 'user_section_status/edit'
      end
    end

# 乗車キロ数の計算と更新
    params[:user_rosen_status][:ride_kilo_sum] = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).ride_true.not_abolish.section_user_is(current_user).sum(:kilo)
    params[:user_rosen_status][:ride_abo_kilo_sum] = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).ride_true.abolished.section_user_is(current_user).sum(:kilo)
    @SumUpdateSearch = UserRosenStatus.where("rosen_id = ? and user_id = ?", params[:rosen_id], current_user)
    @SumUpdateSearch.each do |s|
      $id = s.id
    end
    @SumUpdate = UserRosenStatus.find($id)

    if @SumUpdate.update(rosen_param)
      if params[:continue_edit]
        redirect_to ({:controller => 'user_section_statuses', :action => 'edit'}), :notice => '更新しました。'
      else
        redirect_to ({:controller => 'rosens', :action => 'show'}), :notice => '更新しました。'
      end
    else
      render :template => 'user_section_status/edit'
    end

  end

  private

  def ride_param
    params.require(:user_section_status).permit(:ride_day, :ride_chk)
  end

  def rosen_param
    params.require(:user_rosen_status).permit(:ride_kilo_sum, :ride_abo_kilo_sum)
  end
end
