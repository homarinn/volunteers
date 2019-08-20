class VolunteersController < ApplicationController
  def index
    @volunteers = Volunteer.where.not(organization_id: nil).page(params[:page]).per(20).order(created_at: "DESC")
  end

  def show
    @volunteer = Volunteer.find(params[:id])
  end
end