class Api::V1::ProgressLogsController < ApplicationController
    def create
        # 生の params ではなく、安全に許可した progress_log_params を使う
        puts "お届けものの中身: #{progress_log_params.inspect}"

        render json: { status: "success" }, status: :ok
    end

    private

    # 許可するパラメータの型を安全に定義する（Strong Parameters）
    def progress_log_params
        params.require(:progress_log).permit(:title, :status)
    end
end
