class VolunteersController < ApplicationController
  def index
    @volunteers = Volunteer.all
  end

  def show
    @volunteer = Volunteer.find(params[:id])
  end
end