class Api::InvitesController < ApplicationController
  private
  def collection
    @invites ||= parent.invites
  end

  def resource
    @invite ||= collection.find params[:id]
  end
end