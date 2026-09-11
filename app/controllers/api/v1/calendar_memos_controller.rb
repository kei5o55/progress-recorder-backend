class Api::V1::CalendarMemosController < ApplicationController
    # GET /api/v1/calendar_memos
    def index
        @calendar_memos=CalendarMemo.all

        render json: @calendar_memos, status: :ok
    end

    # POST /api/v1/calendar_memos
    def create
        @calendar_memo = CalendarMemo.new(calendar_memo_params)

        if @calendar_memo.save
        render json: @calendar_memo, status: :created
        else
        render json: { errors: @calendar_memo.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /api/v1/calendar_memos/:id
    def update
        # URLの params[:id] で既存データを特定
        @calendar_memo = CalendarMemo.find(params[:id])

        # .update メソッドで変更を適用
        if @calendar_memo.update(calendar_memo_params)
            render json: @calendar_memo, status: :ok
        else
            render json: { errors: @calendar_memo.errors.full_messages }, status: :unprocessable_entity
        end
    rescue ActiveRecord::RecordNotFound
        render json: { error: "指定されたメモが見つかりません" }, status: :not_found
    end

    # DELETE /api/v1/calendar_memos/:id
    def destroy
        @calendar_memo = CalendarMemo.find(params[:id])
        @calendar_memo.destroy

        # 成功したら 204 No Content を返して終了（render は書かない）
        head :no_content
    rescue ActiveRecord::RecordNotFound
        render json: { error: "指定されたメモが見つかりません" }, status: :not_found
    end

    private

    def calendar_memo_params
        params.require(:calendar_memo).permit(:date, :text, :created_at)
    end
    #{
    #"calendar_memo": {
    #    "date": "2026-09-08",
    #    "text":"test"
    #}
    #}
end