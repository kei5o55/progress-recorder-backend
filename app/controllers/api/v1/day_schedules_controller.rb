class Api::V1::DaySchedulesController < ApplicationController
    def index
        render json: {
          status: "ok",
          message: "day_schedules is connected successfully!",
          timestamp: Time.current
        }, status: :ok
      end

      def create
        # TODO: DaySchedule 作成ロジックを実装
        day_schedule = DaySchedule.new(day_schedule)

        if day_schedule.save
          render json: day_schedule, status: :created
        else
          render json: { error: day_schedule.errors.full_messages }, status: :unprocessable_entity
        end
        
      end

      private

      def day_schedule_params
        # Strong Parameters (例)
        # params.require(:day_schedule).permit(:date, :title, :start_time, :end_time)
        p = params.require(:day_schedule).permit(
          :date,
          :title,
          :start_hour,
          :end_hour,
          :end_minute,
          :color,
          :project_id,
        )
      end
end
