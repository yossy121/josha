class CompaniesController < ApplicationController
  def index
    @companies = Company.not_delete.order(:category_id, :company_sub_id)
    @Categories = Category.not_delete.order(:id)
  end

  def show
    @companies = Company.category_is(params[:category_id]).order(:company_sub_id)
    @Categories = Category.not_delete.order(:id)
  end
end
