class Api::V1::CalendarMemosController < ApplicationController
    def index
        render json: {
          status: "ok",
          message: "calendar_memos is connected successfully!",
          timestamp: Time.current
        }, status: :ok
    end

    def create
        # TODO: CalendarMemo 作成ロジックを実装
        calendar_memo = CalendarMemo.new(calendar_memo_params)

        if calendar_memo.save
            render json: calendar_memo, status: :created
        else
            render json: { error: calendar_memo.errors.full_messages }, status: :unprocessable_entity
        end
        
    end

    private

    def calendar_memo_params
        # Strong Parameters (例)
        # params.require(:calendar_memo).permit(:date, :content)
        p = params.require(:calendar_memo).permit(
            :date,
            :text,
            :created_at,
            )
    end
end
