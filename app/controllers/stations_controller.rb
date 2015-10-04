class StationsController < ApplicationController
  def index
  end

  def show
    @Company = Company.find(params[:company_id])
    @Stations = Station.where(["company_id = ? and delete_flag = ?", params[:company_id], 0]).order(:name_ruby)
  end
end
