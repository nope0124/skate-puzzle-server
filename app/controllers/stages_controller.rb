class StagesController < ApplicationController
    def new
        @stage = Stage.new
    end

    def create
        @stage = Stage.new(stage_params)
        @stage.save
        redirect_to stages_path
    end
    
    def index
        @stages = Stage.all
        @users = User.all
    end

    def show
        @stage = Stage.find(params[:id])
    end

    def edit
        @stage = Stage.find(params[:id])
    end

    def update
        @stage = Stage.find(params[:id])
        @stage.update(stage_params)
        redirect_to stage_path(@stage.id)
    end

    private
    def stage_params
        params.require(:stage).permit(:board)
    end
end
