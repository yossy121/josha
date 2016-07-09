class RosensController < ApplicationController
  def companyindex
    @Company = Company.find(params[:company_id])
    @Rosens = Rosen.eager_load(:start_station, :end_station, :user_rosen_statuses).company_is(params[:company_id]).rosen_user_is(current_user).not_delete.order(:rosen_sub_id)
    @Rosen_sum = Rosen.eager_load(:start_station, :end_station).company_is(params[:company_id]).not_delete.sum(:kilo)
#    @Rosen_sum = Rosen.eager_load(:start_station, :end_station, :user_rosen_statuses).company_is(params[:company_id]).rosen_user_is(current_user).not_delete.sum(:kilo)
    @Ride_sum = Rosen.eager_load(:start_station, :end_station, :user_rosen_statuses).company_is(params[:company_id]).rosen_user_is(current_user).not_delete.sum(:ride_kilo_sum)
    @Ride_abo_sum = Rosen.eager_load(:start_station, :end_station, :user_rosen_statuses).company_is(params[:company_id]).rosen_user_is(current_user).not_delete.sum(:ride_abo_kilo_sum)
  end

  def stateindex
    @State = State.find(params[:state_id])
    @Sections = Section.eager_load(:rosen, :start_station, :end_station, :user_section_statuses).state_is(params[:state_id]).section_user_is(current_user).order("rosen_id, section_sub_id ASC")
  end

  def show
    @Rosen = Rosen.eager_load(:company).find(params[:rosen_id])
    @Sections = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).section_user_is(current_user).not_delete.order("section_sub_id ASC")
    @Section_sum = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).ride_true.section_user_is(current_user).not_delete.sum(:kilo)
  end
end
