class Api::V1::ProgressLogsController < ApplicationController
    def create
        puts "\n========================================"
        puts "🚀 [開通成功] フロントから進捗データが届きました！"
        puts "お届けものの中身: #{params[:progress_log].inspect}"
        puts "========================================\n"

        render json:{status: "success",message:"Rails received your data"},status: :ok
    end
end
