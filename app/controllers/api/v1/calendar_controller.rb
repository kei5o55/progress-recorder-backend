class Api::V1::CalendarController < ApplicationController
    def index
        render json: {
          status: "ok",
          message: "calendar_memos is connected successfully!",
          timestamp: Time.current
        }, status: :ok
    end

    def create
        # TODO: CalendarMemo 作成ロジックを実装
    end

    private

    def calendar_memo_params
        # Strong Parameters (例)
        # params.require(:calendar_memo).permit(:date, :content)
    end
end
