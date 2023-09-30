class Api::V1::StagesController < ApplicationController
    def show
        stage = Stage.find(params[:id])
        board = stage.board.split("\r\n")
        board = board.reverse
        height = board.length
        width = board[0].length
        data = {
            width: width,
            height: height,
            board: board
        }
        render json: data.as_json
    end
end
