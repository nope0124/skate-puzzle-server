class UsersController < ApplicationController
    def index
        @users = User.all
        @stages_count = Stage.count
    end
    
    def show
        @user = User.find(params[:id])
        @stages = Stage.all
        stage_ids = Stage.pluck(:id)

        # ユーザーに関連するUserStageProgressを一度のクエリで取得
        user_stage_progresses = UserStageProgress.where(user_id: @user.id, stage_id: stage_ids).index_by(&:stage_id)

        @progresses = stage_ids.map do |stage_id|
            user_stage_progresses[stage_id]&.progress || -1
        end
    end
end
