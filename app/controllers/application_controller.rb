class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource, :collection

  skip_before_action :verify_authenticity_token, if: :json_request?

  before_action :authenticate, :set_decorator_context

  attr_reader :current_user

  rescue_from ActiveRecord::RecordInvalid, ActiveModel::StrictValidationFailed do
    render :errors, status: :unprocessable_entity
  end

  def create
    build_resource

    resource.save!
  end

  def update
    resource.update! resource_params
  end

  def destroy
    resource.destroy!

    head :no_content
  end

  private
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      auth_token = AuthToken.find_by value: token

      if auth_token&.expired?
        auth_token.destroy!
      else
        @current_user = User.joins(:auth_tokens).find_by(auth_tokens: { value: token })
      end
    end
  end

  def json_request?
    request.format.json?
  end

  def set_decorator_context context_values={}
    @decorator_context = { context: context_values }
  end
end