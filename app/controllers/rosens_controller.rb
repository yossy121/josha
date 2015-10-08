class RosensController < ApplicationController
  def index
    @Company = Company.find(params[:company_id])
    @Rosens = Rosen.eager_load(:start_station, :end_station).where(["rosens.company_id = ? and rosens.delete_flag = ?", params[:company_id], 0]).order(:rosen_sub_id)
    @Rosens_abo = Section.where(["sections.rosen_id = ? and sections.abolished_flag = ? and sections.delete_flag = ?", params[:company_id], 1, 0]).sum(:kilo)
  end

  def show
    @Rosen = Rosen.find(params[:rosen_id])
    @Sections = Section.where(["sections.rosen_id = ? and sections.delete_flag = ?", params[:rosen_id], 0]).order("section_sub_id ASC")
  end
end
