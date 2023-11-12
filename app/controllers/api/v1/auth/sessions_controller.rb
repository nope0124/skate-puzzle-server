# 認証確認用コントローラー
class Api::V1::Auth::SessionsController < ApplicationController
  before_action :configure_permitted_parameters

  def index
    if current_api_v1_user
      render json: { status: 200, current_user: current_api_v1_user }
    else
      render json: { status: 500, message: "ユーザーが存在しません" }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
