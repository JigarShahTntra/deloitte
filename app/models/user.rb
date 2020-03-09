# frozen_string_literal: true

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable

  has_one_attached :profile_picture
  belongs_to :organization, optional: true
  validates :name, presence: true
  after_create :invite_user

  def has_roles
    roles.pluck(:name).join(',')
  end

  def invite_user
    invite!
  end
end
