module Api
  module V1
    class CommitsController < ApplicationController
      # TODO: 認証機能を追加する場合は有効化してください
      # before_action :authenticate_user!

      # GET /api/v1/projects/:project_id/commits
      def index
        # 1. URLの project_id から対象のプロジェクトを取得
        project = Project.find(params[:project_id])

        # 2. そのプロジェクトに紐づくコミット一覧を新しい順で取得
        commits = project.commits.order(created_at: :desc)

        # 3. 整形して JSON で返却
        render json: commits.map { |commit| commit_response(commit) }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Project not found" }, status: :not_found
      end

      # POST /api/v1/projects/:project_id/commits
      def create
        # 1. Project ID から検索
        project = Project.find(params[:project_id])
        commit = project.commits.build(commit_params)

        # TODO: 作成者の紐付けを行う場合は有効化してください
        # commit.user = current_user

        if commit.save
          render json: commit_response(commit), status: :ok
        else
          render json: { errors: commit.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Project not found or access denied" }, status: :not_found
      end

      private

      def commit_params
        # 1. フロントから届くキャメルケースのキーを許可
        p = params.require(:commit).permit(
          :projectId,
          :note,
          :durationMs,
          :startedAt,
          :endedAt,
          :image
        )

        # 2. Railsモデルの属性名（スネークケース）にマッピング
        {
          project_id: p[:projectId],
          note: p[:note],
          duration_ms: p[:durationMs],
          started_at: p[:startedAt],
          ended_at: p[:endedAt],
          image: p[:image]
        }
      end

      def commit_response(commit)
        {
          id: commit.id,
          project_id: commit.project_id,
          note: commit.note,
          started_at: commit.started_at,
          ended_at: commit.ended_at,
          duration_ms: commit.duration_ms,
          # Active Storage やモデルのメソッドから生成されたURLを返却
          image_url: commit.try(:image_url)
        }
      end
    end
  end
end