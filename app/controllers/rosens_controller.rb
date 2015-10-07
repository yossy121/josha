class RosensController < ApplicationController
  def index
  end

  def show
    @Company = Company.find(params[:company_id])
    @Rosens = Rosen.eager_load(:start_station, :end_station).where(["rosens.company_id = ? and rosens.delete_flag = ?", params[:company_id], 0]).order(:rosen_sub_id)
  end
end
