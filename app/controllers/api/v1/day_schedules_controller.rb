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
      end

      private

      def day_schedule_params
        # Strong Parameters (例)
        # params.require(:day_schedule).permit(:date, :title, :start_time, :end_time)
      end
end
