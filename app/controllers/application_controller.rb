class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :resource, :collection

  def index
    collection
  end

  def show
    resource
  end

  def create
    build_resource

    resource.save!
  end

  def update
    resource.update!
  end

  def destroy
    resource.destroy!
  end
end
