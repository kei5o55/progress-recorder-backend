# app/controllers/api/v1/projects_controller.rb
module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authenticate_user! # Devise-JWTによる認証チェック

      # GET /api/v1/projects
      def index
        # ログインユーザーのプロジェクトのみ取得
        projects = current_user.projects.order(created_at: :desc)
        commits = current_user.commits
        sessions = current_user.work_sessions

        render json: {
          projects: projects,
          commits: commits,
          sessions: sessions
        }, status: :ok
      end

      # POST /api/v1/projects
      def create
        project = current_user.projects.build(project_params)

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

      def project_params
        params.require(:project).permit(
          :name, :due_date, :memo, :target_hours,
          :pomodoro_work_minutes, :pomodoro_break_minutes
        )
      end
    end
  end
end