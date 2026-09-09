class Api::V1::DaySchedulesController < ApplicationController
  # GET /api/v1/day_schedules
  def index
    # ⭕ 複数形の @day_schedules に修正！
    @day_schedules = DaySchedule.all1
    #@day_schedules = DaySchedule.include(:user).all 将来的にこんな感じでNプラス1を解消
    # DaySchedule.all だと他人の予定まで取れちゃうので、
    # カレントユーザーに紐づく予定だけを取得する（これで認可・セキュリティも安全！）
    #@day_schedules = current_user.day_schedules.includes(:user)

    render json: @day_schedules, status: :ok
  end

  # POST /api/v1/day_schedules
  def create
    # ⭕ day_schedule ではなく day_schedule_params を渡す！
    @day_schedule = DaySchedule.new(day_schedule_params)

    if @day_schedule.save
      render json: @day_schedule, status: :created
    else
      # 他のコントローラーと合わせて errors (複数形) にしておくとフロントが扱いやすいで！
      render json: { errors: @day_schedule.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/day_schedules/:id
  def destroy
    @day_schedule = DaySchedule.find(params[:id])
    @day_schedule.destroy
    head :no_content # 204 No Content を返す（完璧！）
  rescue ActiveRecord::RecordNotFound
    render json: { error: "指定されたスケジュールが見つかりません" }, status: :not_found
  end

  private

  def day_schedule_params
    # ⭕ p = への代入を外して、:start_minute を追加！
    params.require(:day_schedule).permit(
      :date,
      :title,
      :start_hour,
      :start_minute, # ← これが抜けてたで！
      :end_hour,
      :end_minute,
      :color,
      :project_id
    )
  end
end