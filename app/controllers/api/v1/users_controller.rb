class Api::V1::UsersController < ApplicationController
  #before_action :authenticate_user! #ログインしてるか確認
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {user: {name: @user.name,email: @user.email}}
    else
      render json: {errors: {body: @user.error}},status: :unprocessable_entity
    end
  end

  def me
    render json: {
      message: "認証成功！ログイン中のユーザーです",
      #user: current_user
    }
  end

  def test
    render json: {
      message: "テステステストだよー",
      timestamp: Time.current
    }
  end
end