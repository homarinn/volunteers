class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all.page(params[:page]).per(20)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to organizations_path
    else
      render :new
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name)
  end
end
