# frozen_string_literal: true

class Organization::OrganizationsController < ApplicationController
  # load_and_authorize_resource
  before_action :set_organization, only: %w[edit update show]

  def index
    @organizations = Organization.accessible_by(current_ability, :manage)
  end

  def new
    @organization = Organization.new
    @user = @organization.users.build
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      @organization.users.first.add_role :admin
      redirect_to redirect_path, notice: 'Invitation sent to email.'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  private

  def redirect_path
    current_user.present? ? organizations_path : new_user_session_path
  end

  def set_organization
    @organization = Organization.find_by(id: params[:id])
  end

  def organization_params
    params.require(:organization).permit(:name, :cin, :phone_number, :pan, :gst, :url, :address, users_attributes: %i[id email name password])
  end
end
