class StatesController < ApplicationController
  def index
    @States = State.where(["delete_flag = ?", 0]).order(:id)
  end
end
