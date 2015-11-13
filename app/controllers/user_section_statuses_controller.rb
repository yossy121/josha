class UserSectionStatusesController < ApplicationController
  def edit
    @Rosen = Rosen.find(params[:rosen_id])
    @Sections = Section.eager_load(:user_section_statuses).rosen_is(params[:rosen_id]).section_user_is(current_user).order("section_sub_id ASC")
  end

  def update 

  end
end
