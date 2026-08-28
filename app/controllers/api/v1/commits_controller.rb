# app/controllers/api/v1/commits_controller.rb
module Api
  module V1
    class CommitsController < ApplicationController
      #ユーザ別をなくそう
      #before_action :authenticate_user!
      
      def index
        # 1. URLの project_id から対象のプロジェクトを取得
        project = Project.find(params[:project_id])

        # 2. そのプロジェクトに紐づくコミット一覧を新しい順で取得
        commits = project.commits.order(created_at: :desc)

        # 3. JSON で返却
        render json: commits, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Project not found" }, status: :not_found
      end

      # POST /api/v1/projects/:project_id/commits
      def create
        #いったんユーザ別をなくそう
        # 👇 ここをコメントアウトして、URLから誰でも Project を探せるようにしている
        #project = current_user.projects.find(params[:project_id])
        # 1. ユーザーを挟まず、直接 Project ID から検索
        project = Project.find(params[:project_id])
        commit = project.commits.build(commit_params)
        #こっちも
        # 👇 ここもコメントアウトされているため、作成者（user）の紐付けがない
        #commit.user = current_user

        if commit.save
          render json: commit, status: :ok
        else
          render json: { errors: commit.errors.full_messages }, status: :unprocessable_entity
        end
        rescue ActiveRecord::RecordNotFound
          # 他人のプロジェクトIDを指定した場合は「見つかりません（404）」を返す
          render json: { error: "Project not found or access denied" }, status: :not_found
        end
      end

      private

      def commit_params
        # :image を追加許可
        params.require(:commit).permit(:note, :duration_ms, :started_at, :ended_at, :image)
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