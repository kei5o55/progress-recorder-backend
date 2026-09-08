class Api::V1::CalendarController < ApplicationController
    def index
        render json: {
          status: "ok",
          message: "Rails API is connected successfully!",
          timestamp: Time.current
        }, status: :ok
        
    end

    def create
        
    end

    private


end
