require 'rails_helper'

RSpec.describe "Api::V1::Commits", type: :request do
  describe "POST /api/v1/projects/:project_id/commits (Commit作成)" do
    let!(:project) { FactoryBot.create(:project) }

    context "正常なパラメータが送信された場合" do
      let(:valid_params) do
        {
          commit: {
            note: "ポモドーロ1セッション完了",
            durationMs: "1500000",
            startedAt: "2026-08-28T10:00:00.000Z",
            endedAt: "2026-08-28T10:25:00.000Z"
          }
        }
      end

      it "200 OK が返り、DBに Commit が 1 件追加されること" do
        expect {
          post "/api/v1/projects/#{project.id}/commits", params: valid_params
        }.to change(project.commits, :count).by(1)

        expect(response).to have_http_status(:ok)
      end

      it "キャメルケースのキーがスネークケースのカラムへ正しく保存されること" do
        post "/api/v1/projects/#{project.id}/commits", params: valid_params

        created_commit = Commit.last

        expect(created_commit.duration_ms).to eq 1_500_000
        expect(created_commit.note).to eq "ポモドーロ1セッション完了"
        expect(created_commit.project_id).to eq project.id
      end
    end

    context "存在しない project_id が URL に指定された場合" do
      let(:valid_params) do
        {
          commit: {
            note: "テスト"
          }
        }
      end

      it "404 Not Found が返り、エラーメッセージが含まれること" do
        post "/api/v1/projects/invalid-id-9999/commits", params: valid_params

        expect(response).to have_http_status(:not_found)

        json = JSON.parse(response.body)
        expect(json["error"]).to eq "Project not found or access denied"
      end
    end
  end
end