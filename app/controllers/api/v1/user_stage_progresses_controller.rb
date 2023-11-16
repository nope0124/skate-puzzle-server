class Api::V1::UserStageProgressesController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %i[create destroy]
  
  def create
    user_stage_progress = UserStageProgress.find_by(user_id: current_api_v1_user.id, stage_id: params[:stage_id])
    if user_stage_progress.nil?
      # create
      user_stage_progress = UserStageProgress.new
      user_stage_progress.stage_id = params[:stage_id]
      user_stage_progress.user_id = current_api_v1_user.id
      user_stage_progress.progress = 0
      if user_stage_progress.save!
        render json: { status: 200 }
      else
        render json: { status: 500 }
      end
    else
      # update
      progress = user_stage_progress.progress
      new_progress = params[:progress].to_i
      if progress < new_progress
        user_stage_progress.update(progress: new_progress)
      end
      render json: { status: 200 }
    end
  end

  def destroy
    UserStageProgress.where(user_id: current_api_v1_user.id).destroy_all
    user_stage_progress = UserStageProgress.new
    user_stage_progress.stage_id = params[:stage_id]
    user_stage_progress.user_id = current_api_v1_user.id
    user_stage_progress.progress = 0
    user_stage_progress.save!
    render json: { status: 200 }
  end
end
