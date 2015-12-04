class CompaniesController < ApplicationController
  def index
    @companies = Company.where("delete_flag = ?", 0).order(:category_id, :company_sub_id)
  end

  def new
  end
end
