class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { message: 'ログイン成功', user: resource }, status: :ok
    else
      render json: { error: 'ログイン失敗' }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    render json: { message: 'ログアウト完了' }, status: :ok
  end
end