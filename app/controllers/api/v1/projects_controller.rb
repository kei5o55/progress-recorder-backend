# app/controllers/api/v1/projects_controller.rb
module Api
  module V1
    class ProjectsController < ApplicationController
      #before_action :authenticate_user! # Devise-JWTによる認証チェック

      # GET /api/v1/projects
      def index
        # ログインユーザーのプロジェクトのみ取得
        #projects = current_user.projects.order(created_at: :desc)
        #commits = current_user.commits
        #sessions = current_user.work_sessions

        #いったんはログイン機能なしで全部のprojectsを
        projects = Project.all.order(created_at: :desc)
  
        # Commit や WorkSession モデルがある場合は全件取得（無ければ [] でOK）
        commits = defined?(Commit) ? Commit.all : []
        sessions = defined?(WorkSession) ? WorkSession.all : []

        render json: projects,status: :ok
        #json: {
          #projects: projects,
          #commits: commits,
          #sessions: sessions
        #}, status: :ok
      end

      # POST /api/v1/projects
      def create
        project = Project.new(project_params)

        if project.save
          render json: project, status: :created
        else
          render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/projects/:id
      def destroy
        project = current_user.projects.find(params[:id])
        project.destroy
        head :no_content
      end

      private

      def project_params # ユーザid等を許可しない
        # 1. フロントから届くキャメルケースのキー名を許可する
        p = params.require(:project).permit(
          :name,
          :memo,
          :completed,
          :dueDate,               
          :endDate,               
          :targetHours,           
          :pomodoroWorkMinutes,   
          :pomodoroBreakMinutes   
        )

        # 2. Railsの属性名（スネークケース）にマッピングしてハッシュで返す
        {
          name: p[:name],
          memo: p[:memo],
          completed: p[:completed],
          due_date: p[:dueDate],
          end_date: p[:endDate],
          target_hours: p[:targetHours],
          pomodoro_work_minutes: p[:pomodoroWorkMinutes],
          pomodoro_break_minutes: p[:pomodoroBreakMinutes]
        }
      end
    end
  end
end