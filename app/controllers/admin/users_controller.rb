# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
    authorize! :manage, @users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.add_role params[:user][:role]
    if @user.invite!
      redirect_to admin_users_path, notice: 'User Added Successfully'
    else
      render :new
    end
  end

  def edit; end

  def update
    @user.remove_role @user.has_roles
    @user.add_role params[:user][:role]
    if @user.update(user_params)
      if params[:profile_picture].present?
        @user.profile_picture.attach(params[:profile_picture])
      end
      redirect_to admin_users_path, notice: 'User Updated Successfully'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User Deleted Successfully'
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    authorize! :manage, @user
  end

  def user_params
    params.require(:user).permit(:name, :email, :profile_picture)
  end
end
