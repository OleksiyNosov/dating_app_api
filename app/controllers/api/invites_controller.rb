class Api::InvitesController < ApplicationController
  private
  def collection
    @invites ||= parent.invites
  end

  def resource
    @invite ||= parent.find params[:id]
  end
end