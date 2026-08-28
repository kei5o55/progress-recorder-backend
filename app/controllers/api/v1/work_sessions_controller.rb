module Api
    module v1
        class WorkSessionsController < ApplicationController
            def index
                work_sessions = WorkSession.all.order(created_at: :desc)
                render json: work_sessions, status: :ok
            end

            def create
                work_session = WorkSession.new(work_session_params)

                if work_session.save
                    render json: work_session, status: :created
                else
                    render json: { errors: work_session.errors.full_messages }, status: :unprocessable_entity
                end
            end

        end
    end
end  
