class Api::V1::DaySchedulesController < ApplicationController
  # GET /api/v1/day_schedules
  def index
    @day_schedules = DaySchedule.all
    #@day_schedules = DaySchedule.include(:user).all 将来的にこんな感じでNプラス1を解消
    # DaySchedule.all だと他人の予定まで取れちゃうので、
    # カレントユーザーに紐づく予定だけを取得する
    #@day_schedules = current_user.day_schedules.includes(:user)

    render json: @day_schedules, status: :ok
  end

  # POST /api/v1/day_schedules
  def create
    @day_schedule = DaySchedule.new(day_schedule_params)
    #同じ時間帯被ってないか（ユーザごと、かつ日付ごとに）調べて、その場合はじくようにもしないといけない（フロントで一応弾いてはいるが）

    if @day_schedule.save
      render json: @day_schedule, status: :created
    else
      render json: { errors: @day_schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/day_schedules/:id
  def destroy
    @day_schedule = DaySchedule.find(params[:id])
    @day_schedule.destroy
    head :no_content 
  rescue ActiveRecord::RecordNotFound
    render json: { error: "指定されたスケジュールが見つかりません" }, status: :not_found
  end

  private

  def day_schedule_params
    params.require(:day_schedule).permit(
      :date,
      :title,
      :start_hour,
      :start_minute, 
      :end_hour,
      :end_minute,
      :color,
      :project_id
    )

    #    {
    #  "day_schedule":{
    #    "data": "2026-09-08",
    #    "title": "テストタイトル",
    #    "start_hour": "10",
    #    "start_minute": "0",
    #    "end_hour": "3",
    #    "end_minute": "0",
    #    "project_id": ""
    #  }
    #}
  end
end