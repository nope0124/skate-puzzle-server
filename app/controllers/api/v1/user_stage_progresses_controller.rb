class Api::V1::UserStageProgressesController < ApplicationController
  before_action :authenticate_api_v1_user!, except: %i[create destroy]
  
  def create
    user_stage_progress = UserStageProgress.new
    user_stage_progress.stage_id = params[:stage_id]
    user_stage_progress.user_id = current_api_v1_user.id
    user_stage_progress.progress = 0
    if user_stage_progress.save!
      render json: { status: 200 }
    else
      render json: { status: 500 }
    end
  end

  def update

  end

  def destroy
    UserStageProgress.where(id: current_api_v1_user.id).destroy_all
  end
end
