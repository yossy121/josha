class CompaniesController < ApplicationController
  def index
    @companies = Company.where(["abolished_flag = ? and delete_flag = ?", 0, 0]).order(:category_id, :company_sub_id)
  end

  def new
  end
end
