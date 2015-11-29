class UserSectionStatusesController < ApplicationController
  def edit
    @Rosen = Rosen.find(params[:rosen_id])
    @Sections = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).section_user_is(current_user).order("section_sub_id ASC")
  end

  def update 
    @Rosen = Rosen.find(params[:rosen_id])
    @Sections = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).section_user_is(current_user).order("section_sub_id ASC")

    if params[:user_section_status][:startcheck] > params[:user_section_status][:endcheck]
      tmp = params[:user_section_status][:endcheck]
      params[:user_section_status][:endcheck] = params[:user_section_status][:startcheck]
      params[:user_section_status][:startcheck] = tmp
    end
# 日付が入力されていた場合はチェックフラグを入れる処理
    if params[:user_section_status]["ride_day(1i)"].present? and params[:user_section_status]["ride_day(2i)"].present? and params[:user_section_status]["ride_day(3i)"].present?
      params[:user_section_status][:ride_chk] = '1'
    end

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
      redirect_to ({:controller => 'rosens', :action => 'show'}), :notice => '更新しました。'
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
