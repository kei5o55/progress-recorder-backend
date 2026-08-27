# app/controllers/api/v1/commits_controller.rb
module Api
  module V1
    class CommitsController < ApplicationController
      #ユーザ別をなくそう
      #before_action :authenticate_user!

      # POST /api/v1/projects/:project_id/commits
      def create
        #いったんユーザ別をなくそう
        #project = current_user.projects.find(params[:project_id])
        # 1. ユーザーを挟まず、直接 Project ID から検索
        project = Project.find(params[:project_id])
        commit = project.commits.build(commit_params)
        #こっちも
        #commit.user = current_user

        if commit.save
          render json: commit_response(commit), status: :created
        else
          render json: { errors: commit.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def commit_params
        # image カラムとしてファイルを受け取る
        params.require(:commit).permit(:note, :ended_at, :image)
      end

      def commit_response(commit)
        {
          id: commit.id,
          project_id: commit.project_id,
          note: commit.note,
          ended_at: commit.ended_at,
          # Active Storage で生成されたURLを返す
          image_url: commit.image_url
        }
      end
    end
  end
end