# spec/requests/api/v1/day_schedules_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::DaySchedules", type: :request do
  describe "GET /api/v1/day_schedules (一覧取得)" do
    let!(:day_schedule1) { FactoryBot.create(:day_schedule, target_date: Date.current) }
    let!(:day_schedule2) { FactoryBot.create(:day_schedule, target_date: Date.yesterday) }

    it "200 OK が返り、スケジュール一覧が取得できること" do
      get "/api/v1/day_schedules"

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json.length).to eq 2
    end
  end

  describe "GET /api/v1/day_schedules/:target_date (日付指定取得)" do
    let!(:day_schedule) { FactoryBot.create(:day_schedule, target_date: Date.current) }

    context "存在する日付が指定された場合" do
      it "200 OK が返り、該当する日のスケジュールが取得できること" do
        get "/api/v1/day_schedules/#{day_schedule.target_date}"

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json["targetDate"]).to eq day_schedule.target_date.to_s
      end
    end

    context "存在しない日付が指定された場合" do
      it "404 Not Found が返ること" do
        get "/api/v1/day_schedules/2099-12-31"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /api/v1/day_schedules (作成・更新)" do
    context "正常なパラメータが送信された場合" do
      let(:valid_params) do
        {
          daySchedule: {
            targetDate: Date.current.to_s,
            notes: "読書と紅茶を嗜む時間"
          }
        }
      end

      it "201 Created が返り、DBに正しく保存されること" do
        expect {
          post "/api/v1/day_schedules", params: valid_params
        }.to change(DaySchedule, :count).by(1)

        # 最新の Rack 仕様に則り、数値または :created でお確かめいたします
        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)
        expect(json["notes"]).to eq "読書と紅茶を嗜む時間"
      end
    end

    context "不正なパラメータ（日付が未入力など）の場合" do
      let(:invalid_params) do
        {
          daySchedule: {
            targetDate: nil,
            notes: "無効なデータ"
          }
        }
      end

      it "422 Unprocessable Content が返り、エラーが含まれること" do
        post "/api/v1/day_schedules", params: invalid_params

        # 非推奨警告を避けるため 422 数値指定、または :unprocessable_content を用います
        expect(response).to have_http_status(422)

        json = JSON.parse(response.body)
        expect(json["errors"]).to be_present
      end
    end
  end
end
