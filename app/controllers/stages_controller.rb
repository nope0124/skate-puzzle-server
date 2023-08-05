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
    end

    def show
        @stage = Stage.find(params[:id])
    end

    private
    def stage_params
        params.require(:stage).permit(:board)
    end
end
